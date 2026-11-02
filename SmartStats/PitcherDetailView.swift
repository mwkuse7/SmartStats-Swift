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
    
    var body: some View {
        NavigationStack {
            VStack {
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
                            Text(pitcher.position.name)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Text("\(pitcher.season) Stats")
                    .padding(.vertical, 20)
                
                PitcherStatScrollView(players: [pitcher], activeColumn: "none")
                
                Spacer()
            }
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
    }
}

#Preview {
    PitcherDetailView(pitcher: PitcherSeason.example)
        .environment(FavoritePitchers())
}
