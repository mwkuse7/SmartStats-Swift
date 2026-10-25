//
//  StatScrollView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/8/26.
//

import SwiftUI

struct BatterStatScrollView: View {
    var players: [BatterSeason]
    
    var activeColumn: String
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0){
                        ForEach(BatterStatAbbreviation.collection, id: \.self) { stat in
                            Text(BatterStatAbbreviation.abbreviate(stat))
                                .font(.caption.italic().bold())
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
                                        BatterStatAbbreviation.abbreviate(
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
    }
}

#Preview {
    let players = [BatterSeason.example]
    let activeColumn = "ops"
    
    return BatterStatScrollView(players: players, activeColumn: activeColumn)
}
