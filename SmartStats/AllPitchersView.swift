//
//  AllPitchersView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/25/26.
//

import SwiftUI

struct AllPitchersView: View {
    @State private var showingPlayerView = false
    @State private var activePlayer: PitcherSeason? = nil

    @State private var players: [PitcherSeason] = []

    // Active Sort Descriptor
    @State private var activeColumn: String = "era"
    @State private var sortOrder = [
        SortDescriptor(\PitcherSeason.stat.era, order: .forward)
    ]

    // Search Text
    @State private var searchText: String = ""

    // Filter Players Based on Search Text
    var filteredPlayers: [PitcherSeason] {
        if searchText.isEmpty == false {
            return players.sorted(using: sortOrder).filter {
                $0.player.fullName.localizedStandardContains(searchText)
            }
        } else {
            return players.sorted(using: sortOrder)
        }
    }

    var body: some View {
        NavigationStack {
            if players.isEmpty == false {
                ScrollView {
                    HStack(spacing: 0) {
                        PitchersView(players: filteredPlayers)

                        ScrollViewReader { proxy in
                            PitcherStatScrollView(
                                players: filteredPlayers,
                                activeColumn: activeColumn
                            )
                            .onChange(of: activeColumn) { _, newValue in
                                withAnimation {
                                    proxy.scrollTo(newValue, anchor: .leading)
                                }

                                sortOrder = setSortOrder(newValue)
                            }
                            .onAppear {
                                proxy.scrollTo(activeColumn, anchor: .leading)

                                sortOrder = setSortOrder(activeColumn)
                            }
                        }
                    }
                }
                .navigationTitle("All Batters: \(players.count)")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Refresh", systemImage: "arrow.clockwise") {
                            Task {
                                await fetchPlayers()
                            }
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Button("Delete", systemImage: "trash") {

                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort By", selection: $activeColumn) {
                                ForEach(
                                    PitcherStatAbbreviation.collection,
                                    id: \.self
                                ) { stat in
                                    Text(
                                        PitcherStatAbbreviation.abbreviate(stat)
                                    )
                                    .tag(stat)
                                }
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
            } else {
                ProgressView()
            }
        }
        .onAppear(perform: loadPlayerData)
    }

    func removeAllPlayers() {
        do {
            let url = URL.documentsDirectory.appending(path: "Pitchers.json")
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Unable to remove players.")
        }
    }

    func savePlayerData(data: Data) {
        let url = URL.documentsDirectory.appending(path: "Pitchers.json")

        do {
            try data.write(
                to: url,
                options: [.atomic, .completeFileProtection]
            )
        } catch {
            print("Error saving player data.")
        }
    }

    func loadPlayerData() {
        let url = URL.documentsDirectory.appending(path: "Pitchers.json")
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(AllPitchers.self, from: data)

            players = decoded.pitchers
        } catch {
            Task {
                await fetchPlayers()
            }
        }
    }

    func fetchPlayers() async {
        var allPlayerData = Data()

        let limit = 200
        var offset = 0
        var moreData = true

        while moreData {
            guard
                let url = URL(
                    string:
                        "https://statsapi.mlb.com/api/v1/stats?stats=season&group=pitching&season=2026&playerPool=Qualified&sportId=1&limit=\(limit)&offset=\(offset)&sortStat=era&order=asc"
                )
            else { return }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(
                    AllPitchers.self,
                    from: data
                )

                if !decoded.pitchers.isEmpty {
                    allPlayerData.append(data)
                    players.append(contentsOf: decoded.pitchers)
                    offset += limit

                    if players.count >= decoded.totalSplits {
                        moreData = false
                    }
                } else {
                    moreData = false
                }

            } catch let DecodingError.keyNotFound(key, context) {
                print(
                    "Missing Key '\(key.stringValue)' at path: \(context.codingPath)"
                )
            } catch let DecodingError.typeMismatch(type, context) {
                print(
                    "Type mismatch for \(type) at path: \(context.codingPath)"
                )
            } catch let DecodingError.valueNotFound(type, context) {
                print(
                    "Value not found for \(type) at path: \(context.codingPath)"
                )
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted at path: \(context.codingPath)")
            } catch {
                print("Error loading players: \(error.localizedDescription)")
            }
        }

        savePlayerData(data: allPlayerData)
    }

    func setSortOrder(_ sortOrder: String) -> [SortDescriptor<PitcherSeason>] {
        switch sortOrder {
        case "age":
            return [SortDescriptor(\PitcherSeason.stat.age, order: .reverse)]
        case "gamesPlayed":
            return [
                SortDescriptor(\PitcherSeason.stat.gamesPlayed, order: .reverse)
            ]
        case "gamesStarted":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesStarted,
                    order: .reverse
                )
            ]
        case "groundOuts":
            return [
                SortDescriptor(\PitcherSeason.stat.groundOuts, order: .reverse)
            ]
        case "airOuts":
            return [
                SortDescriptor(\PitcherSeason.stat.airOuts, order: .reverse)
            ]
        case "runs":
            return [SortDescriptor(\PitcherSeason.stat.runs, order: .forward)]
        case "doubles":
            return [
                SortDescriptor(\PitcherSeason.stat.doubles, order: .forward)
            ]
        case "triples":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.triples,
                    order: .forward
                )
            ]
        case "homeRuns":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.homeRuns,
                    order: .forward
                )
            ]
        case "strikeOuts":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeOuts,
                    order: .reverse
                )
            ]
        case "baseOnBalls":
            return [
                SortDescriptor(\PitcherSeason.stat.baseOnBalls, order: .forward)
            ]
        case "intentionalWalks":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.intentionalWalks,
                    order: .reverse
                )
            ]
        case "hits":
            return [
                SortDescriptor(\PitcherSeason.stat.hits, order: .forward)
            ]
        case "hitByPitch":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.hitByPitch,
                    order: .forward
                )
            ]
        case "avg":
            return [
                SortDescriptor(\PitcherSeason.stat.avg, order: .forward)
            ]
        case "atBats":
            return [SortDescriptor(\PitcherSeason.stat.atBats, order: .reverse)]
        case "obp":
            return [
                SortDescriptor(\PitcherSeason.stat.obp, order: .forward)
            ]
        case "slg":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.slg,
                    order: .forward
                )
            ]
        case "ops":
            return [
                SortDescriptor(\PitcherSeason.stat.ops, order: .forward)
            ]
        case "caughtStealing":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.caughtStealing,
                    order: .reverse
                )
            ]
        case "stolenBases":
            return [
                SortDescriptor(\PitcherSeason.stat.stolenBases, order: .forward)
            ]
        case "stolenBasePercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.stolenBasePercentage,
                    order: .forward
                )
            ]
        case "caughtStealingPercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.caughtStealingPercentage,
                    order: .reverse
                )
            ]
        case "groundIntoDoublePlay":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.groundIntoDoublePlay,
                    order: .reverse
                )
            ]
        case "numberOPitches":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.numberOfPitches,
                    order: .reverse
                )
            ]
        case "era":
            return [
                SortDescriptor(\PitcherSeason.stat.era, order: .forward)
            ]
        case "inningsPitched":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inningsPitched,
                    order: .reverse
                )
            ]
        case "wins":
            return [SortDescriptor(\PitcherSeason.stat.wins, order: .reverse)]
        case "losses":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.losses,
                    order: .reverse
                )
            ]
        case "saves":
            return [
                SortDescriptor(\PitcherSeason.stat.saves, order: .reverse)
            ]
        case "saveOpportunities":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.saveOpportunities,
                    order: .reverse
                )
            ]
        case "holds":
            return [
                SortDescriptor(\PitcherSeason.stat.holds, order: .reverse)
            ]
        case "blownSaves":
            return [
                SortDescriptor(\PitcherSeason.stat.blownSaves, order: .reverse)
            ]
        case "earnedRuns":
            return [
                SortDescriptor(\PitcherSeason.stat.earnedRuns, order: .forward)
            ]
        case "whip":
            return [SortDescriptor(\PitcherSeason.stat.whip, order: .forward)]
        case "battersFaced":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.battersFaced,
                    order: .reverse
                )
            ]
        case "outs":
            return [SortDescriptor(\PitcherSeason.stat.outs, order: .reverse)]
        case "gamesPitched":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesPitched,
                    order: .reverse
                )
            ]
        case "completeGames":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.completeGames,
                    order: .reverse
                )
            ]
        case "shutouts":
            return [
                SortDescriptor(\PitcherSeason.stat.shutouts, order: .reverse)
            ]
        case "strikes":
            return [
                SortDescriptor(\PitcherSeason.stat.strikes, order: .reverse)
            ]
        case "strikePercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikePercentage,
                    order: .reverse
                )
            ]
        case "hitBatsmen":
            return [
                SortDescriptor(\PitcherSeason.stat.hitBatsmen, order: .reverse)
            ]
        case "balks":
            return [SortDescriptor(\PitcherSeason.stat.balks, order: .reverse)]
        case "wildPitches":
            return [
                SortDescriptor(\PitcherSeason.stat.wildPitches, order: .reverse)
            ]
        case "pickoffs":
            return [
                SortDescriptor(\PitcherSeason.stat.pickoffs, order: .reverse)
            ]
        case "totalBases":
            return [
                SortDescriptor(\PitcherSeason.stat.totalBases, order: .forward)
            ]
        case "groundOutsToAirouts":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.groundOutsToAirouts,
                    order: .reverse
                )
            ]
        case "winPercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.winPercentage,
                    order: .reverse
                )
            ]
        case "pitchesPerInning":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.pitchesPerInning,
                    order: .forward
                )
            ]
        case "gamesFinished":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesFinished,
                    order: .reverse
                )
            ]
        case "strikeoutWalkRatio":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeoutWalkRatio,
                    order: .reverse
                )
            ]
        case "strikeoutsPer9Inn":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeoutsPer9Inn,
                    order: .reverse
                )
            ]
        case "walksPer9Inn":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.walksPer9Inn,
                    order: .forward
                )
            ]
        case "hitsPer9Inn":
            return [
                SortDescriptor(\PitcherSeason.stat.hitsPer9Inn, order: .forward)
            ]
        case "runsScoredPer9":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.runsScoredPer9,
                    order: .forward
                )
            ]
        case "homeRunsPer9":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.homeRunsPer9,
                    order: .forward
                )
            ]
        case "inheritedRunners":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inheritedRunners,
                    order: .reverse
                )
            ]
        case "inheritedRunnersScored":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inheritedRunnersScored,
                    order: .reverse
                )
            ]
        case "catchersInterference":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.catchersInterference,
                    order: .reverse
                )
            ]
        case "sacBunts":
            return [
                SortDescriptor(\PitcherSeason.stat.sacBunts, order: .reverse)
            ]
        case "sacFlies":
            return [
                SortDescriptor(\PitcherSeason.stat.sacFlies, order: .reverse)
            ]
        default:
            return [SortDescriptor(\PitcherSeason.stat.era, order: .forward)]
        }
    }
}

#Preview {
    AllBattersView()
}
