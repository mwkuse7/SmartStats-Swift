//
//  StatScrollView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/8/26.
//

import SwiftUI

struct StatScrollView: View {
    var players: [BatterSeason]
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(players, id: \.player.id) { player in
                    HStack {
                        ForEach(player.statsArray, id: \.key) { stat in
                            VStack {
                                Text(
                                    StatAbbreviation.abbreviate(
                                        stat.key
                                    )
                                )
                                .font(.caption.italic())

                                Text(stat.value)
                                    .font(.headline)
                            }
                            .frame(width: 50)
                        }
                    }
                    .frame(height: 50)
                    .border(Color.secondary, width: 0.5)
                }
            }

        }
        .scrollIndicators(.hidden)
    }
    
    init(players: [BatterSeason]) {
        self.players = players
        
        UIScrollView.appearance().bounces = false
    }
}

#Preview {
    var players = [BatterSeason]()
    players.append(BatterSeason.example)
    players.append(BatterSeason.example2)
    players.append(BatterSeason.example3)
    
    return StatScrollView(players: players)
}
