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
    
    var body: some View {
        NavigationStack {
            VStack {
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
                            Text(batter.position.name)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Text("\(batter.season) Stats")
                    .padding(.vertical, 20)
                
                BatterStatScrollView(players: [batter], activeColumn: "none")
                
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
    }
}

#Preview {
    
    BatterDetailView(batter: BatterSeason.example)
        .environment(FavoriteBatters())
}
