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
        Text(String(favorites.batters.count))
        Button("Favorite") {
            if favorites.contains(batter) {
                favorites.remove(batter)
            } else {
                favorites.add(batter)
            }
        }
    }
}

#Preview {
    
    BatterDetailView(batter: BatterSeason.example)
        .environment(FavoriteBatters())
}
