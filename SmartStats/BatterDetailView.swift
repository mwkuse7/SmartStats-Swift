//
//  BatterDetailView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/29/26.
//

import SwiftUI

struct BatterDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(FavoriteBatters.self) var favorites
    
    var batter: BatterSeason
    
    // Batter Stats for Previous Seasons
    @State private var previousSeasons: [BatterSeason] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Image(batter.team.name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    
                    VStack {
                        Text(batter.player.fullName)
                            .font(.title)
                        
                        Text(batter.team.name)
                            .foregroundStyle(.secondary)
                        
                        HStack {
                            Text(batter.position?.name ?? "Unknown")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                ForEach(previousSeasons, id: \.season) { season in
                    VStack {
                        Text("\(season.season)")
                            .font(.headline)
                        
                        BatterStatScrollView(players: [season], activeColumn: "none")
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
            }
            .padding(.vertical, 20)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if favorites.contains(batter) {
                            favorites.remove(batter)
                        } else {
                            favorites.add(batter)
                        }
                    } label: {
                        if favorites.contains(batter) {
                            Label("Favorite", systemImage: "star.fill")
                                .labelStyle(.titleAndIcon)
                        } else {
                            Label("Favorite", systemImage: "star")
                                .labelStyle(.titleAndIcon)
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
        guard let url = URL(string: "https://statsapi.mlb.com/api/v1/people/\(String(batter.id))/stats?stats=yearByYear&group=hitting") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let fetchedStats = try JSONDecoder().decode(AllBatters.self, from: data)
            
            previousSeasons = fetchedStats.batters
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
    
    BatterDetailView(batter: BatterSeason.example)
        .environment(FavoriteBatters())
}
