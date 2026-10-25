//
//  AllBattersView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/30/26.
//

import SwiftUI

struct AllBattersView: View {
    @State private var showingPlayerView = false
    @State private var activePlayer: BatterSeason? = nil
    
    @State private var players: [BatterSeason] = []

    // Active Sort Descriptor
    @State private var activeColumn: String = "ops"
    @State private var sortOrder = [
        SortDescriptor(\BatterSeason.stat.ops, order: .reverse)
    ]

    // Search Text
    @State private var searchText: String = ""

    // Filter Players Based on Search Text
    var filteredPlayers: [BatterSeason] {
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
                        BattersView(players: filteredPlayers)

                        ScrollViewReader { proxy in
                            BatterStatScrollView(
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
                                ForEach(BatterStatAbbreviation.collection, id: \.self)
                                { stat in
                                    Text(BatterStatAbbreviation.abbreviate(stat))
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
            let url = URL.documentsDirectory.appending(path: "Players.json")
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Unable to remove players.")
        }
    }
    
    func savePlayerData(data: Data) {
        let url = URL.documentsDirectory.appending(path: "Players.json")
        
        do {
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving player data.")
        }
    }
    
    func loadPlayerData() {
        let url = URL.documentsDirectory.appending(path: "Players.json")
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(AllBatters.self, from: data)
            
            players = decoded.batters
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
                        "https://statsapi.mlb.com/api/v1/stats?stats=season&group=hitting&season=2026&playerPool=Qualified&sportId=1&limit=\(limit)&offset=\(offset)&sortStat=onBasePlusSlugging&order=desc"
                )
            else { return }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoded = try JSONDecoder().decode(AllBatters.self, from: data)
                
                if !decoded.batters.isEmpty {
                    allPlayerData.append(data)
                    players.append(contentsOf: decoded.batters)
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
                print("Type mismatch for \(type) at path: \(context.codingPath)")
            } catch let DecodingError.valueNotFound(type, context) {
                print("Value not found for \(type) at path: \(context.codingPath)")
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted at path: \(context.codingPath)")
            } catch {
                print("Error loading players: \(error.localizedDescription)")
            }
        }
        
        savePlayerData(data: allPlayerData)
    }

    func setSortOrder(_ sortOrder: String) -> [SortDescriptor<BatterSeason>] {
        switch sortOrder {
        case "age":
            return [SortDescriptor(\BatterSeason.stat.age, order: .reverse)]
        case "atBats":
            return [SortDescriptor(\BatterSeason.stat.atBats, order: .reverse)]
        case "atBatsPerHomeRun":
            return [
                SortDescriptor(
                    \BatterSeason.stat.atBatsPerHomeRun,
                    order: .reverse
                )
            ]
        case "avg":
            return [SortDescriptor(\BatterSeason.stat.avg, order: .reverse)]
        case "airOuts":
            return [SortDescriptor(\BatterSeason.stat.airOuts, order: .reverse)]
        case "babip":
            return [SortDescriptor(\BatterSeason.stat.babip, order: .reverse)]
        case "baseOnBalls":
            return [
                SortDescriptor(\BatterSeason.stat.baseOnBalls, order: .reverse)
            ]
        case "catchersInterference":
            return [
                SortDescriptor(
                    \BatterSeason.stat.catchersInterference,
                    order: .reverse
                )
            ]
        case "caughtStealing":
            return [
                SortDescriptor(
                    \BatterSeason.stat.caughtStealing,
                    order: .reverse
                )
            ]
        case "caughtStealingPercentage":
            return [
                SortDescriptor(
                    \BatterSeason.stat.caughtStealingPercentage,
                    order: .reverse
                )
            ]
        case "doubles":
            return [SortDescriptor(\BatterSeason.stat.doubles, order: .reverse)]
        case "gamesPlayed":
            return [
                SortDescriptor(\BatterSeason.stat.gamesPlayed, order: .reverse)
            ]
        case "groundIntoDoublePlay":
            return [
                SortDescriptor(
                    \BatterSeason.stat.groundIntoDoublePlay,
                    order: .reverse
                )
            ]
        case "groundOuts":
            return [
                SortDescriptor(\BatterSeason.stat.groundOuts, order: .reverse)
            ]
        case "groundOutsToAirOuts":
            return [
                SortDescriptor(
                    \BatterSeason.stat.groundOutsToAirouts,
                    order: .reverse
                )
            ]
        case "hitByPitch":
            return [
                SortDescriptor(\BatterSeason.stat.hitByPitch, order: .reverse)
            ]
        case "hits":
            return [SortDescriptor(\BatterSeason.stat.hits, order: .reverse)]
        case "homeRuns":
            return [
                SortDescriptor(\BatterSeason.stat.homeRuns, order: .reverse)
            ]
        case "intentionalWalks":
            return [
                SortDescriptor(
                    \BatterSeason.stat.intentionalWalks,
                    order: .reverse
                )
            ]
        case "leftOnBase":
            return [
                SortDescriptor(\BatterSeason.stat.leftOnBase, order: .reverse)
            ]
        case "numberOfPitches":
            return [
                SortDescriptor(
                    \BatterSeason.stat.numberOfPitches,
                    order: .reverse
                )
            ]
        case "obp":
            return [SortDescriptor(\BatterSeason.stat.obp, order: .reverse)]
        case "ops":
            return [SortDescriptor(\BatterSeason.stat.ops, order: .reverse)]
        case "plateAppearances":
            return [
                SortDescriptor(
                    \BatterSeason.stat.plateAppearances,
                    order: .reverse
                )
            ]
        case "rbi":
            return [SortDescriptor(\BatterSeason.stat.rbi, order: .reverse)]
        case "runs":
            return [SortDescriptor(\BatterSeason.stat.runs, order: .reverse)]
        case "sacBunts":
            return [
                SortDescriptor(\BatterSeason.stat.sacBunts, order: .reverse)
            ]
        case "sacFlies":
            return [
                SortDescriptor(\BatterSeason.stat.sacFlies, order: .reverse)
            ]
        case "slg":
            return [SortDescriptor(\BatterSeason.stat.slg, order: .reverse)]
        case "stolenBasePercentage":
            return [
                SortDescriptor(
                    \BatterSeason.stat.stolenBasePercentage,
                    order: .reverse
                )
            ]
        case "stolenBases":
            return [
                SortDescriptor(\BatterSeason.stat.stolenBases, order: .reverse)
            ]
        case "strikeOuts":
            return [
                SortDescriptor(\BatterSeason.stat.strikeOuts, order: .reverse)
            ]
        case "totalBases":
            return [
                SortDescriptor(\BatterSeason.stat.totalBases, order: .reverse)
            ]
        case "triples":
            return [SortDescriptor(\BatterSeason.stat.triples, order: .reverse)]
        default:
            return [SortDescriptor(\BatterSeason.stat.ops, order: .reverse)]
        }
    }
}

#Preview {
    AllBattersView()
}
