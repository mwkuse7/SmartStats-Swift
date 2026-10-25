//
//  ContentView.swift
//  SmartStats
//
//  Created by Max Kuse on 8/15/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Batters", systemImage: "figure.baseball") {
                AllBattersView()
            }
            
            Tab("Favorites", systemImage: "star.fill") {
                Text("Favorites")
            }
            
            Tab("Pitchers", systemImage: "baseball.fill") {
                AllPitchersView()
            }
        }
    }
}

#Preview {
    ContentView()
}
