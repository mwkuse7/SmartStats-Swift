//
//  PlayersView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/24/26.
//

import SwiftUI

struct PlayersView: View {
    var players: [BatterSeason]
    
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
                    size * 0.5
                }
                .frame(height: 50)
                .border(Color.secondary, width: 0.5)
            }
        }
    }
}

#Preview {
    var players = [BatterSeason]()
    players.append(BatterSeason.example)
    players.append(BatterSeason.example2)
    players.append(BatterSeason.example3)
    
    return PlayersView(players: players)
}
