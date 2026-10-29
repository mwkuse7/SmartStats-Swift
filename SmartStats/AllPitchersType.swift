//
//  AllPitchersType.swift
//  SmartStats
//
//  Created by Max Kuse on 10/25/26.
//

import Foundation

struct PitcherSeason: Codable, Equatable, Identifiable {
    let season: String
    let stat: Stat
    let team: Team
    let player: Player
    let league: League
    let numTeams: Int
    let rank: Int
    let position: Position
    
    var id: Int {
        player.id
    }
    
    static var example = PitcherSeason(season: "2025", stat: Stat(age: 23, gamesPlayed: 32, gamesStarted: 32, groundOuts: 167, airOuts: 166, runs: 45, doubles: 37, triples: 2, homeRuns: 11, strikeOuts: 216, baseOnBalls: 42, intentionalWalks: 0, hits: 136, hitByPitch: 6, avg: ".199", atBats: 684, obp: ".251", slg: ".307", ops: ".558", caughtStealing: 2, stolenBases: 4, stolenBasePercentage: ".667", caughtStealingPercentage: ".333", groundIntoDoublePlay: 13, numberOfPitches: 2997, era: "1.97", inningsPitched: "187.2", wins: 10, losses: 10, saves: 0, saveOpportunities: 0, holds: 0, blownSaves: 0, earnedRuns: 41, whip: "0.95", battersFaced: 733, outs: 563, gamesPitched: 32, completeGames: 1, shutouts: 0, strikes: 1952, strikePercentage: ".650", hitBatsmen: 6, balks: 0, wildPitches: 2, pickoffs: 1, totalBases: 210, groundOutsToAirouts: "1.01", winPercentage: ".500", pitchesPerInning: "15.97", gamesFinished: 0, strikeoutWalkRatio: "5.14", strikeoutsPer9Inn: "10.36", walksPer9Inn: "2.01", hitsPer9Inn: "6.52", runsScoredPer9: "2.16", homeRunsPer9: "0.53", inheritedRunners: 0, inheritedRunnersScored: 0, catchersInterference: 0, sacBunts: 0, sacFlies: 1), team: Team(id: 134, name: "Pittsburgh Pirates", link: "/api/v1/teams/134"), player: Player(id: 694973, fullName: "Paul Skenes", link: "/api/v1/people/694973", firstName: "Paul", lastName: "Skenes"), league: League(id: 104, name: "NL"), numTeams: 1, rank: 1, position: Position(code: "1", name: "Pitcher", type: "Pitcher", abbreviation: "P"))
    
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
        let gamesPlayed: Int
        let gamesStarted: Int
        let groundOuts: Int
        let airOuts: Int
        let runs: Int
        let doubles: Int
        let triples: Int
        let homeRuns: Int
        let strikeOuts: Int
        let baseOnBalls: Int
        let intentionalWalks: Int
        let hits: Int
        let hitByPitch: Int
        let avg: String
        let atBats: Int
        let obp: String
        let slg: String
        let ops: String
        let caughtStealing: Int
        let stolenBases: Int
        let stolenBasePercentage: String
        let caughtStealingPercentage: String
        let groundIntoDoublePlay: Int
        let numberOfPitches: Int
        let era: String
        let inningsPitched: String
        let wins: Int
        let losses: Int
        let saves: Int
        let saveOpportunities: Int
        let holds: Int
        let blownSaves: Int
        let earnedRuns: Int
        let whip: String
        let battersFaced: Int
        let outs: Int
        let gamesPitched: Int
        let completeGames: Int
        let shutouts: Int
        let strikes: Int
        let strikePercentage: String
        let hitBatsmen: Int
        let balks: Int
        let wildPitches: Int
        let pickoffs: Int
        let totalBases: Int
        let groundOutsToAirouts: String
        let winPercentage: String
        let pitchesPerInning: String
        let gamesFinished: Int
        let strikeoutWalkRatio: String
        let strikeoutsPer9Inn: String
        let walksPer9Inn: String
        let hitsPer9Inn: String
        let runsScoredPer9: String
        let homeRunsPer9: String
        let inheritedRunners: Int
        let inheritedRunnersScored: Int
        let catchersInterference: Int
        let sacBunts: Int
        let sacFlies: Int
        
        
        enum CodingKeys: String, CodingKey {
            case age
            case gamesPlayed
            case gamesStarted
            case groundOuts
            case airOuts
            case runs
            case doubles
            case triples
            case homeRuns
            case strikeOuts
            case baseOnBalls
            case intentionalWalks
            case hits
            case hitByPitch
            case avg
            case atBats
            case obp
            case slg
            case ops
            case caughtStealing
            case stolenBases
            case stolenBasePercentage
            case caughtStealingPercentage
            case groundIntoDoublePlay
            case numberOfPitches
            case era
            case inningsPitched
            case wins
            case losses
            case saves
            case saveOpportunities
            case holds
            case blownSaves
            case earnedRuns
            case whip
            case battersFaced
            case outs
            case gamesPitched
            case completeGames
            case shutouts
            case strikes
            case strikePercentage
            case hitBatsmen
            case balks
            case wildPitches
            case pickoffs
            case totalBases
            case groundOutsToAirouts
            case winPercentage
            case pitchesPerInning
            case gamesFinished
            case strikeoutWalkRatio
            case strikeoutsPer9Inn
            case walksPer9Inn
            case hitsPer9Inn
            case runsScoredPer9
            case homeRunsPer9
            case inheritedRunners
            case inheritedRunnersScored
            case catchersInterference
            case sacBunts
            case sacFlies
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
    
    static func ==(lhs: PitcherSeason, rhs: PitcherSeason) -> Bool {
        lhs.player.id == rhs.player.id
    }
    
}

struct AllPitchers: Codable {
    
    let totalSplits: Int
    let pitchers: [PitcherSeason]
    
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
        var extractedPitchers = [PitcherSeason]()
        var totalSplits = 0
        
        while !outerStatsContainer.isAtEnd {
            if let splitsContainer = try? outerStatsContainer.nestedContainer(keyedBy: OuterStatsCodingKeys.self) {
                if splitsContainer.contains(.totalSplits) {
                    totalSplits = try splitsContainer.decode(Int.self, forKey: .totalSplits)
                }
                
                if splitsContainer.contains(.splits) {
                    extractedPitchers = try splitsContainer.decode([PitcherSeason].self, forKey: .splits)
                    break
                }
            } else {
                _ = try? outerStatsContainer.superDecoder()
            }
        }
        
        self.pitchers = extractedPitchers
        self.totalSplits = totalSplits
    }
}

