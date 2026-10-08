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

    var body: some View {
        NavigationStack {
            if let players = players {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(players.batters, id: \.player.id) {
                            player in
                            HStack {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image(player.team.name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40)
                                        
                                        Text(
                                            "\(String(player.player.firstName.first ?? " ")). \(player.player.lastName)"
                                        )
                                        .foregroundStyle(.black)
                                        
                                        Spacer()
                                    }
                                    .containerRelativeFrame(.horizontal) { size, axis in
                                        size * 0.45
                                    }
                                }

                                ScrollView(.horizontal) {
                                    HStack {
                                        ForEach(player.statsArray, id: \.key) {
                                            stat in
                                            VStack {
                                                Text(StatAbbreviation.abbreviate(stat.key))
                                                    .font(.caption.italic())
                                                
                                                Text(stat.value)
                                                    .font(.headline)
                                            }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .padding(.leading)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .navigationTitle("Players")
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
                    "https://statsapi.mlb.com/api/v1/stats?stats=season&group=hitting&season=2025&playerPool=All&sortStat=onBasePlusSlugging&order=desc"
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
}

#Preview {
    ContentView()
}
