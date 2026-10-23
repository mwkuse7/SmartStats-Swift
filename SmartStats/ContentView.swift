//
//  ContentView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/15/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingPlayerView = false
    @State private var activePlayer: BatterSeason? = nil
    @State private var players: AllBatters? = nil

    // Active Sort Descriptor
    @State private var activeColumn: String = "age"
    @State private var sortOrder = [
        SortDescriptor(\BatterSeason.stat.ops, order: .reverse)
    ]

    // Sort players using active SortDescriptor
    var sortedBatters: [BatterSeason]? {
        players?.batters.sorted(using: sortOrder) ?? nil
    }

    // Search Text
    @State private var searchText: String = ""

    // Filter Players Based on Search Text
    var filteredPlayers: [BatterSeason]? {
        if searchText.isEmpty == false {
            return sortedBatters?.filter {
                $0.player.fullName.localizedStandardContains(searchText)
            }
        } else {
            return sortedBatters
        }
    }

    var body: some View {
        NavigationStack {
            if let filteredPlayers {
                ScrollView {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Player")
                                    .font(.headline.italic())
                            }
                            .containerRelativeFrame(.horizontal) { size, axis in
                                size * 0.45
                            }
                            .frame(height: 30)
                            .border(Color.secondary, width: 0.5)

                            ForEach(filteredPlayers, id: \.player.id) { player in
                                HStack {
                                    Button {
                                        // Button to show player view

                                    } label: {
                                        HStack {
                                            Image(player.team.name)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)

                                            Text(
                                                "\(String(player.player.firstName.first ?? " ")). \(player.player.lastName)"
                                            )
                                            .foregroundStyle(.black)
                                            .font(.subheadline)

                                            Spacer()
                                        }
                                        .padding(.leading)
                                    }
                                }
                                .containerRelativeFrame(.horizontal) {
                                    size,
                                    axis in
                                    size * 0.45
                                }
                                .frame(height: 50)
                                .border(Color.secondary, width: 0.5)
                            }
                        }

                        ScrollViewReader { proxy in
                            StatScrollView(
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
                .navigationTitle("All Players")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Refresh", systemImage: "arrow.clockwise") {
                            Task {
                                await loadPlayers()
                            }
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort By", selection: $activeColumn) {
                                ForEach(StatAbbreviation.collection, id: \.self)
                                { stat in
                                    Text(StatAbbreviation.abbreviate(stat))
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
        .task {
            if players?.batters.isEmpty ?? true {
                await loadPlayers()
            }
        }
    }

    func loadPlayers() async {
        guard
            let url = URL(
                string:
                    "https://statsapi.mlb.com/api/v1/stats?stats=season&group=hitting&season=2026&playerPool=All&sortStat=onBasePlusSlugging&order=desc"
            )
        else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(AllBatters.self, from: data)

            players = decoded

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
    ContentView()
}
