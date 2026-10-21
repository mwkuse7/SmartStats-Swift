//
//  StatScrollView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/8/26.
//

import SwiftUI

struct StatScrollView: View {
    var players: [BatterSeason]
    
    var activeColumn: String
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0){
                        ForEach(StatAbbreviation.collection, id: \.self) { stat in
                            Text(StatAbbreviation.abbreviate(stat))
                                .font(.caption.italic())
                                .frame(width: 50, height: 30)
                                .background(stat == activeColumn ? .blue.opacity(0.75) : .clear)
                                .id(stat)
                        }
                    }
                    .border(Color.secondary, width: 0.5)
                    
                    ForEach(players, id: \.player.id) { player in
                        HStack(spacing: 0) {
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
                                .frame(width: 50, height: 50)
                                .background(stat.key == activeColumn ? .blue.opacity(0.75) : .clear)
                            }
                        }
                        .border(Color.secondary, width: 0.5)
                    }
                }
            }
    }
    
    init(players: [BatterSeason], activeColumn: String) {
        self.players = players
        self.activeColumn = activeColumn

        UIScrollView.appearance().bounces = false
    }
}

#Preview {
    var players = [BatterSeason]()
    players.append(BatterSeason.example)
    players.append(BatterSeason.example2)
    players.append(BatterSeason.example3)
    
    let activeColumn = "ops"
    
    return StatScrollView(players: players, activeColumn: activeColumn)
}
