//
//  ContentView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/15/26.
//

import SwiftUI

struct ContentView: View {
    @State private var favoriteBatters = FavoriteBatters()
    @State private var favoritePitchers = FavoritePitchers()
    
    var body: some View {
        TabView {
            Tab("Batters", systemImage: "figure.baseball") {
                AllBattersView()
            }
            
            Tab("Favorites", systemImage: "star.fill") {
                FavoritePlayersView()
            }
            
            Tab("Pitchers", systemImage: "baseball.fill") {
                AllPitchersView()
            }
        }
        .environment(favoriteBatters)
        .environment(favoritePitchers)
    }
}

#Preview {
    ContentView()
}
