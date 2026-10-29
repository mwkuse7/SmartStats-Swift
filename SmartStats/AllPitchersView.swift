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

                                sortOrder = PitcherStatAbbreviation.setSortOrder(newValue)
                            }
                            .onAppear {
                                proxy.scrollTo(activeColumn, anchor: .leading)

                                sortOrder = PitcherStatAbbreviation.setSortOrder(activeColumn)
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
}

#Preview {
    AllPitchersView()
}
