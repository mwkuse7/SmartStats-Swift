//
//  PitchersView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/25/26.
//

import SwiftUI

struct PitchersView: View {
    var players: [PitcherSeason]
    
    @State private var activePitcher: PitcherSeason? = nil
    
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
                        activePitcher = player
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
        .sheet(item: $activePitcher) { pitcher in
            PitcherDetailView(pitcher: pitcher)
        }
    }
}

#Preview {
    let players = [PitcherSeason.example]
    
    return PitchersView(players: players)
}
