//
//  SmartStatsApp.swift
//  SmartStats
//
//  Created by Max Kuse on 8/15/26.
//

import SwiftUI

@main
struct SmartStatsApp: App {
    @State private var favoriteBatters = FavoriteBatters()
    @State private var favoritePitchers = FavoritePitchers()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(favoriteBatters)
                .environment(favoritePitchers)
        }
    }
}
