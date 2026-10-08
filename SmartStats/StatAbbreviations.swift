//
//  StatAbbreviation.swift
//  SmartStats
//
//  Created by Max Kuse on 10/7/26.
//

import Foundation

enum StatAbbreviation {
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
}
