//
//  PitcherDetailView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/29/26.
//

import SwiftUI

struct PitcherDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(FavoritePitchers.self) var favorites
    
    var pitcher: PitcherSeason
    
    @State private var previousSeasons: [PitcherSeason] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Image(pitcher.team.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack {
                        Text(pitcher.player.fullName)
                            .font(.title)
                        
                        Text(pitcher.team.name)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            Text(pitcher.position?.name ?? "Unknown")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                ForEach(previousSeasons, id: \.season) { season in
                    VStack {
                        Text(season.season)
                            .font(.headline)
                        PitcherStatScrollView(players: [season], activeColumn: "none")
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
            }
            .scrollBounceBehavior(.basedOnSize)
            .padding(.vertical, 20)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if favorites.contains(pitcher) {
                            favorites.remove(pitcher)
                        } else {
                            favorites.add(pitcher)
                        }
                    } label: {
                        if favorites.contains(pitcher) {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Favorite")
                            }
                        } else {
                            HStack {
                                Image(systemName: "star")
                                Text("Favorite")
                            }
                        }
                    }
                }
            }
        }
        .task {
            await fetchSeasons()
        }
    }
    
    func fetchSeasons() async {
        guard let url = URL(string: "https://statsapi.mlb.com/api/v1/people/\(String(pitcher.id))/stats?stats=yearByYear&group=pitching") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let fetchedStats = try JSONDecoder().decode(AllPitchers.self, from: data)
            
            previousSeasons = fetchedStats.pitchers
            previousSeasons = previousSeasons.sorted(by: { $0.season > $1.season })
            
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
    PitcherDetailView(pitcher: PitcherSeason.example)
        .environment(FavoritePitchers())
}
