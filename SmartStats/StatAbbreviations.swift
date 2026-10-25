//
//  StatAbbreviation.swift
//  SmartStats
//
//  Created by Max Kuse on 10/7/26.
//

import Foundation

enum BatterStatAbbreviation {
    static let statAbbreviations: [String: String] = [
        "age": "AGE",
        "atBats": "AB",
        "atBatsPerHomeRun": "AB/HR",
        "avg": "AVG",
        "airOuts": "AO",
        "babip": "BABIP",
        "baseOnBalls": "BB",
        "catchersInterference": "CI",
        "caughtStealing": "CS",
        "caughtStealingPercentage": "CS%",
        "doubles": "2B",
        "gamesPlayed": "GP",
        "groundIntoDoublePlay": "GDP",
        "groundOuts": "GO",
        "groundOutsToAirouts": "GO/AO",
        "hitByPitch": "HBP",
        "hits": "H",
        "homeRuns": "HR",
        "intentionalWalks": "IBB",
        "leftOnBase": "LOB",
        "numberOfPitches": "NP",
        "obp": "OBP",
        "ops": "OPS",
        "plateAppearances": "PA",
        "rbi": "RBI",
        "runs": "R",
        "sacBunts": "SH",
        "sacFlies": "SF",
        "slg": "SLG",
        "stolenBasePercentage": "SB%",
        "stolenBases": "SB",
        "strikeOuts": "SO",
        "totalBases": "TB",
        "triples": "3B",
    ]
    
    static func abbreviate(_ stat: String) -> String {
        return statAbbreviations[stat] ?? "N/A"
    }
    
    static let collection: [String] = Array(statAbbreviations.keys).sorted()
}

enum PitcherStatAbbreviation {
    static let statAbbreviations: [String: String] = [
        "age": "AGE",
        "gamesPlayed": "GP",
        "gamesStarted": "GS",
        "groundOuts": "GO",
        "airOuts" : "AO",
        "runs" : "R",
        "doubles" : "2B",
        "triples": "3B",
        "homeRuns": "HR",
        "strikeOuts": "SO",
        "baseOnBalls": "BB",
        "intentionalWalks": "IBB",
        "hits": "H",
        "hitByPitch": "HBP",
        "avg" : "AVG",
        "atBats": "AB",
        "obp": "OBP",
        "slg": "SLG",
        "ops": "OPS",
        "caughtStealing": "CS",
        "stolenBases": "SB",
        "stolenBasePercentage": "SB%",
        "caughtStealingPercentage": "CS%",
        "groundIntoDoublePlay": "GDP",
        "numberOfPitches": "NP",
        "era": "ERA",
        "inningsPitched": "IP",
        "wins": "W",
        "losses": "L",
        "saves": "SV",
        "saveOpportunities": "SVO",
        "holds": "HLD",
        "blownSaves": "BS",
        "earnedRuns": "ER",
        "whip": "WHIP",
        "battersFaced": "BF",
        "outs": "O",
        "gamesPitched": "G",
        "completeGames": "CG",
        "shutouts": "SHO",
        "strikes": "K",
        "strikePercentage": "K%",
        "hitBatsmen": "HB",
        "balks": "BK",
        "wildPitches": "WP",
        "pickoffs": "PK",
        "totalBases": "TB",
        "groundOutsToAirouts": "GO/AO",
        "winPercentage": "WPCT",
        "pitchesPerInning": "P/IP",
        "gamesFinished": "GF",
        "strikeoutWalkRatio": "K/BB",
        "strikeoutsPer9Inn": "K/9",
        "walksPer9Inn": "BB/9",
        "hitsPer9Inn": "H/9",
        "runsScoredPer9": "RA9",
        "homeRunsPer9": "HR/9",
        "inheritedRunners": "IR",
        "inheritedRunnersScored": "IS",
        "catchersInterference": "CI",
        "sacBunts": "SH",
        "sacFlies": "SF"
    ]
    
    static func abbreviate(_ stat: String) -> String {
        return statAbbreviations[stat] ?? "N/A"
    }
    
    static let collection: [String] = Array(statAbbreviations.keys).sorted()
}
