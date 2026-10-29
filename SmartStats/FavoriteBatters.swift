//
//  FavoriteBatters.swift
//  SmartStats
//
//  Created by Max Kuse on 10/29/26.
//

import SwiftUI

@Observable
class FavoriteBatters {
    var batters: [BatterSeason]
    private let key = "FavoriteBatters"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([BatterSeason].self, from: data) {
                batters = decoded
                return
            }
        }
        
        batters = []
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(batters) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func add(_ batter: BatterSeason) {
        batters.append(batter)
        save()
    }
    
    func remove(_ batter: BatterSeason) {
        batters.removeAll(where: { $0.player.id == batter.player.id })
        save()
    }
    
    func contains(_ batter: BatterSeason) -> Bool {
        batters.contains(where: { $0.player.id == batter.player.id })
    }
    
}
