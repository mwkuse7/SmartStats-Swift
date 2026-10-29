//
//  FavoritePitchers.swift
//  SmartStats
//
//  Created by Max Kuse on 10/29/26.
//

import SwiftUI

@Observable
class FavoritePitchers {
    var pitchers: [PitcherSeason]
    private let key = "FavoritePitchers"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode([PitcherSeason].self, from: data) {
                pitchers = decoded
                return
            }
        }
        
        pitchers = []
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(pitchers) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func add(_ pitcher: PitcherSeason) {
        pitchers.append(pitcher)
        save()
    }
    
    func remove(_ pitcher: PitcherSeason) {
        pitchers.removeAll(where: { $0.player.id == pitcher.player.id })
        save()
    }
    
    func contains(_ pitcher: PitcherSeason) -> Bool {
        pitchers.contains(where: { $0.player.id == pitcher.player.id })
    }
    
}

