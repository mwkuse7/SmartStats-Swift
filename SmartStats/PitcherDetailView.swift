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
        Text(String(favorites.pitchers.count))
        Button("Favorite") {
            if favorites.contains(pitcher) {
                favorites.remove(pitcher)
            } else {
                favorites.add(pitcher)
            }
        }
    }
}

#Preview {
    
    PitcherDetailView(pitcher: PitcherSeason.example)
        .environment(FavoritePitchers())
}
