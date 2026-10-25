//
//  AllBattersType.swift
//  SmartStats
//
//  Created by Max Kuse on 9/2/26.
//

import Foundation

// Move to separate file
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}

struct BatterSeason: Codable {
    let season: String
    let stat: Stat
    let team: Team
    let player: Player
    let league: League
    let numTeams: Int
    let rank: Int
    let position: Position
    
    static var example = BatterSeason(
        season: "2025",
        stat: Stat(age: 32, atBats: 501, atBatsPerHomeRun: "18.56", avg: ".261", airOuts: 125, babip: ".292", baseOnBalls: 70, catchersInterference: 0, caughtStealing: 2, caughtStealingPercentage: ".143", doubles: 32, gamesPlayed: 132, groundIntoDoublePlay: 5, groundOuts: 127, groundOutsToAirouts: "1.02", hitByPitch: 6, hits: 131, homeRuns: 27, intentionalWalks: 6, leftOnBase: 222, numberOfPitches: 2172, obp: ".357", ops: ".844", plateAppearances: 580, rbi: 75, runs: 72, sacBunts: 0, sacFlies: 3, slg: ".487", stolenBasePercentage: ".857", stolenBases: 12, strikeOuts: 121, totalBases: 244, triples: 0),
        team: Team(id: 143, name: "Philadelphia Phillies", link: "/api/v1/teams/143"),
        player: Player(id: 547180, fullName: "Bryce Harper", link: "/api/v1/people/547180", firstName: "Bryce", lastName: "Harper"),
        league: League(id: 104, name: "NL"),
        numTeams: 1,
        rank: 47,
        position: Position(code: "3", name: "First Base", type: "Infielder", abbreviation: "1B")
    )
    
    var statsArray: [(key: String, value: String)] {
        if let statsDictionary = stat.dictionary {
            return statsDictionary.sorted(by: { $0.key < $1.key }).map { key, value in
                (key, "\(value)")
            }
        }
        return []
    }
    
    enum CodingKeys: String, CodingKey {
        case season
        case stat
        case team
        case player
        case league
        case numTeams
        case rank
        case position
    }
    
    struct Player: Codable, Identifiable {
        let id: Int
        let fullName: String
        let link: String
        let firstName: String
        let lastName: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case fullName
            case link
            case firstName
            case lastName
        }
    }
    
    struct League: Codable, Identifiable {
        let id: Int
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
        }
    }
    
    struct Position: Codable {
        let code: String
        let name: String
        let type: String
        let abbreviation: String
        
        enum CodingKeys: String, CodingKey {
            case code
            case name
            case type
            case abbreviation
        }
    }
    
    struct Stat: Codable {
        let age: Int
        let atBats: Int
        let atBatsPerHomeRun: String
        let avg: String
        let airOuts: Int
        let babip: String
        let baseOnBalls: Int
        let catchersInterference: Int
        let caughtStealing: Int
        let caughtStealingPercentage: String
        let doubles: Int
        let gamesPlayed: Int
        let groundIntoDoublePlay: Int
        let groundOuts: Int
        let groundOutsToAirouts: String
        let hitByPitch: Int
        let hits: Int
        let homeRuns: Int
        let intentionalWalks: Int
        let leftOnBase: Int
        let numberOfPitches: Int
        let obp: String
        let ops: String
        let plateAppearances: Int
        let rbi: Int
        let runs: Int
        let sacBunts: Int
        let sacFlies: Int
        let slg: String
        let stolenBasePercentage: String
        let stolenBases: Int
        let strikeOuts: Int
        let totalBases: Int
        let triples: Int
        
        enum CodingKeys: String, CodingKey {
            case age
            case atBats
            case atBatsPerHomeRun
            case avg
            case airOuts
            case babip
            case baseOnBalls
            case catchersInterference
            case caughtStealing
            case caughtStealingPercentage
            case doubles
            case gamesPlayed
            case groundIntoDoublePlay
            case groundOuts
            case groundOutsToAirouts
            case hitByPitch
            case hits
            case homeRuns
            case intentionalWalks
            case leftOnBase
            case numberOfPitches
            case obp
            case ops
            case plateAppearances
            case rbi
            case runs
            case sacBunts
            case sacFlies
            case slg
            case stolenBasePercentage
            case stolenBases
            case strikeOuts
            case totalBases
            case triples
        }
    }
    
    struct Team: Codable, Identifiable{
        let id: Int
        let name: String
        let link: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case link
        }
    }
    
}

struct AllBatters: Codable {
    
    let totalSplits: Int
    let batters: [BatterSeason]
    
    private enum RootCodingKeys: String, CodingKey {
        case stats
    }
    
    private enum OuterStatsCodingKeys: String, CodingKey {
        case totalSplits
        case splits
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var outerStatsContainer = try rootContainer.nestedUnkeyedContainer(forKey: .stats)
        var extractedBatters = [BatterSeason]()
        var totalSplits = 0
        
        while !outerStatsContainer.isAtEnd {
            if let splitsContainer = try? outerStatsContainer.nestedContainer(keyedBy: OuterStatsCodingKeys.self) {
                if splitsContainer.contains(.totalSplits) {
                    totalSplits = try splitsContainer.decode(Int.self, forKey: .totalSplits)
                }
                
                if splitsContainer.contains(.splits) {
                    extractedBatters = try splitsContainer.decode([BatterSeason].self, forKey: .splits)
                    break
                }
            } else {
                _ = try? outerStatsContainer.superDecoder()
            }
        }
        
        self.batters = extractedBatters
        self.totalSplits = totalSplits
    }
}

