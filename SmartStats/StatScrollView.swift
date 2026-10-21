//
//  StatScrollView.swift
//  SmartStats
//
//  Created by Max Kuse on 10/8/26.
//

import SwiftUI

struct StatScrollView: View {
    var players: [BatterSeason]
    
//    @Binding var activeColumn: String
    
    var body: some View {
//        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        ForEach(StatAbbreviation.collection, id: \.self) { stat in
                            Text(StatAbbreviation.abbreviate(stat))
                                .font(.caption.italic())
                                .frame(width: 50)
                                .id(stat)
                        }
                    }
                    .frame(height: 30)
                    .border(Color.secondary, width: 0.5)
                    
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
//            .onChange(of: activeColumn) { oldValue, newValue in
//                proxy.scrollTo(newValue, anchor: .leading)
//            }
//        }
//        .scrollPosition(id: $activeColumn)
//        .scrollTargetBehavior(.viewAligned)
        
    }
    
    init(players: [BatterSeason]/*, activeColumn: Binding<String>*/) {
        self.players = players
//        self._activeColumn = activeColumn
        UIScrollView.appearance().bounces = false
    }
}

#Preview {
    var players = [BatterSeason]()
    players.append(BatterSeason.example)
    players.append(BatterSeason.example2)
    players.append(BatterSeason.example3)
    
    return StatScrollView(players: players/*, activeColumn: .constant("ops")*/)
}
