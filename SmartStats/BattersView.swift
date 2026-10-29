//
//  BattersView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/24/26.
//

import SwiftUI

struct BattersView: View {
    var players: [BatterSeason]
    
//    @State private var showingDetail = false
    @State private var activePlayer: BatterSeason? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Player")
                    .font(.headline.italic())
            }
            .containerRelativeFrame(.horizontal) { size, axis in
                size * 0.5
            }
            .frame(height: 30)
            .border(Color.secondary, width: 0.5)

            ForEach(players, id: \.player.id) { player in
                HStack {
                    Button {
                        activePlayer = player
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
                    size * 0.5
                }
                .frame(height: 50)
                .border(Color.secondary, width: 0.5)
            }
        }
        .sheet(item: $activePlayer) { player in
            BatterDetailView(batter: player)
        }
    }
}

#Preview {
    let players = [BatterSeason.example]
    
    return BattersView(players: players)
}
