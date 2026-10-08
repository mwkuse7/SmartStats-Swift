//
//  Team.swift
//  SmartStats
//
//  Created by Max Kuse on 9/2/26.
//

import Foundation

struct Team: Codable, Identifiable {
    struct Division: Codable, Identifiable {
        let id: Int
        let name: String
        let link: String
    }
    
    struct League: Codable, Identifiable {
        let id: Int
        let name: String
        let link: String
    }
    
    struct Venue: Codable, Identifiable {
        let id: Int
        let name: String
        let link: String
    }
    
    let abbreviation: String
    let allStarStatus: String
    let division: Division
    let firstYearOfPlay: String
    let id: Int
    let league: League
    let link: String
    let name: String
    let season: Int
    let springLeague: League
    let teamName: String
    let venue: Venue
    let locationName: String
}




