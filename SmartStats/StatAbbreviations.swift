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
    
    static func setSortOrder(_ sortOrder: String) -> [SortDescriptor<BatterSeason>] {
        switch sortOrder {
        case "age":
            return [SortDescriptor(\BatterSeason.stat.age, order: .reverse)]
        case "atBats":
            return [SortDescriptor(\BatterSeason.stat.atBats, order: .reverse)]
        case "atBatsPerHomeRun":
            return [
                SortDescriptor(
                    \BatterSeason.stat.atBatsPerHomeRun,
                    order: .reverse
                )
            ]
        case "avg":
            return [SortDescriptor(\BatterSeason.stat.avg, order: .reverse)]
        case "airOuts":
            return [SortDescriptor(\BatterSeason.stat.airOuts, order: .reverse)]
        case "babip":
            return [SortDescriptor(\BatterSeason.stat.babip, order: .reverse)]
        case "baseOnBalls":
            return [
                SortDescriptor(\BatterSeason.stat.baseOnBalls, order: .reverse)
            ]
        case "catchersInterference":
            return [
                SortDescriptor(
                    \BatterSeason.stat.catchersInterference,
                    order: .reverse
                )
            ]
        case "caughtStealing":
            return [
                SortDescriptor(
                    \BatterSeason.stat.caughtStealing,
                    order: .reverse
                )
            ]
        case "caughtStealingPercentage":
            return [
                SortDescriptor(
                    \BatterSeason.stat.caughtStealingPercentage,
                    order: .reverse
                )
            ]
        case "doubles":
            return [SortDescriptor(\BatterSeason.stat.doubles, order: .reverse)]
        case "gamesPlayed":
            return [
                SortDescriptor(\BatterSeason.stat.gamesPlayed, order: .reverse)
            ]
        case "groundIntoDoublePlay":
            return [
                SortDescriptor(
                    \BatterSeason.stat.groundIntoDoublePlay,
                    order: .reverse
                )
            ]
        case "groundOuts":
            return [
                SortDescriptor(\BatterSeason.stat.groundOuts, order: .reverse)
            ]
        case "groundOutsToAirOuts":
            return [
                SortDescriptor(
                    \BatterSeason.stat.groundOutsToAirouts,
                    order: .reverse
                )
            ]
        case "hitByPitch":
            return [
                SortDescriptor(\BatterSeason.stat.hitByPitch, order: .reverse)
            ]
        case "hits":
            return [SortDescriptor(\BatterSeason.stat.hits, order: .reverse)]
        case "homeRuns":
            return [
                SortDescriptor(\BatterSeason.stat.homeRuns, order: .reverse)
            ]
        case "intentionalWalks":
            return [
                SortDescriptor(
                    \BatterSeason.stat.intentionalWalks,
                    order: .reverse
                )
            ]
        case "leftOnBase":
            return [
                SortDescriptor(\BatterSeason.stat.leftOnBase, order: .reverse)
            ]
        case "numberOfPitches":
            return [
                SortDescriptor(
                    \BatterSeason.stat.numberOfPitches,
                    order: .reverse
                )
            ]
        case "obp":
            return [SortDescriptor(\BatterSeason.stat.obp, order: .reverse)]
        case "ops":
            return [SortDescriptor(\BatterSeason.stat.ops, order: .reverse)]
        case "plateAppearances":
            return [
                SortDescriptor(
                    \BatterSeason.stat.plateAppearances,
                    order: .reverse
                )
            ]
        case "rbi":
            return [SortDescriptor(\BatterSeason.stat.rbi, order: .reverse)]
        case "runs":
            return [SortDescriptor(\BatterSeason.stat.runs, order: .reverse)]
        case "sacBunts":
            return [
                SortDescriptor(\BatterSeason.stat.sacBunts, order: .reverse)
            ]
        case "sacFlies":
            return [
                SortDescriptor(\BatterSeason.stat.sacFlies, order: .reverse)
            ]
        case "slg":
            return [SortDescriptor(\BatterSeason.stat.slg, order: .reverse)]
        case "stolenBasePercentage":
            return [
                SortDescriptor(
                    \BatterSeason.stat.stolenBasePercentage,
                    order: .reverse
                )
            ]
        case "stolenBases":
            return [
                SortDescriptor(\BatterSeason.stat.stolenBases, order: .reverse)
            ]
        case "strikeOuts":
            return [
                SortDescriptor(\BatterSeason.stat.strikeOuts, order: .reverse)
            ]
        case "totalBases":
            return [
                SortDescriptor(\BatterSeason.stat.totalBases, order: .reverse)
            ]
        case "triples":
            return [SortDescriptor(\BatterSeason.stat.triples, order: .reverse)]
        default:
            return [SortDescriptor(\BatterSeason.stat.ops, order: .reverse)]
        }
    }
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
    
    static func setSortOrder(_ sortOrder: String) -> [SortDescriptor<PitcherSeason>] {
        switch sortOrder {
        case "age":
            return [SortDescriptor(\PitcherSeason.stat.age, order: .reverse)]
        case "gamesPlayed":
            return [
                SortDescriptor(\PitcherSeason.stat.gamesPlayed, order: .reverse)
            ]
        case "gamesStarted":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesStarted,
                    order: .reverse
                )
            ]
        case "groundOuts":
            return [
                SortDescriptor(\PitcherSeason.stat.groundOuts, order: .reverse)
            ]
        case "airOuts":
            return [
                SortDescriptor(\PitcherSeason.stat.airOuts, order: .reverse)
            ]
        case "runs":
            return [SortDescriptor(\PitcherSeason.stat.runs, order: .forward)]
        case "doubles":
            return [
                SortDescriptor(\PitcherSeason.stat.doubles, order: .forward)
            ]
        case "triples":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.triples,
                    order: .forward
                )
            ]
        case "homeRuns":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.homeRuns,
                    order: .forward
                )
            ]
        case "strikeOuts":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeOuts,
                    order: .reverse
                )
            ]
        case "baseOnBalls":
            return [
                SortDescriptor(\PitcherSeason.stat.baseOnBalls, order: .forward)
            ]
        case "intentionalWalks":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.intentionalWalks,
                    order: .reverse
                )
            ]
        case "hits":
            return [
                SortDescriptor(\PitcherSeason.stat.hits, order: .forward)
            ]
        case "hitByPitch":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.hitByPitch,
                    order: .forward
                )
            ]
        case "avg":
            return [
                SortDescriptor(\PitcherSeason.stat.avg, order: .forward)
            ]
        case "atBats":
            return [SortDescriptor(\PitcherSeason.stat.atBats, order: .reverse)]
        case "obp":
            return [
                SortDescriptor(\PitcherSeason.stat.obp, order: .forward)
            ]
        case "slg":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.slg,
                    order: .forward
                )
            ]
        case "ops":
            return [
                SortDescriptor(\PitcherSeason.stat.ops, order: .forward)
            ]
        case "caughtStealing":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.caughtStealing,
                    order: .reverse
                )
            ]
        case "stolenBases":
            return [
                SortDescriptor(\PitcherSeason.stat.stolenBases, order: .forward)
            ]
        case "stolenBasePercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.stolenBasePercentage,
                    order: .forward
                )
            ]
        case "caughtStealingPercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.caughtStealingPercentage,
                    order: .reverse
                )
            ]
        case "groundIntoDoublePlay":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.groundIntoDoublePlay,
                    order: .reverse
                )
            ]
        case "numberOPitches":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.numberOfPitches,
                    order: .reverse
                )
            ]
        case "era":
            return [
                SortDescriptor(\PitcherSeason.stat.era, order: .forward)
            ]
        case "inningsPitched":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inningsPitched,
                    order: .reverse
                )
            ]
        case "wins":
            return [SortDescriptor(\PitcherSeason.stat.wins, order: .reverse)]
        case "losses":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.losses,
                    order: .reverse
                )
            ]
        case "saves":
            return [
                SortDescriptor(\PitcherSeason.stat.saves, order: .reverse)
            ]
        case "saveOpportunities":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.saveOpportunities,
                    order: .reverse
                )
            ]
        case "holds":
            return [
                SortDescriptor(\PitcherSeason.stat.holds, order: .reverse)
            ]
        case "blownSaves":
            return [
                SortDescriptor(\PitcherSeason.stat.blownSaves, order: .reverse)
            ]
        case "earnedRuns":
            return [
                SortDescriptor(\PitcherSeason.stat.earnedRuns, order: .forward)
            ]
        case "whip":
            return [SortDescriptor(\PitcherSeason.stat.whip, order: .forward)]
        case "battersFaced":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.battersFaced,
                    order: .reverse
                )
            ]
        case "outs":
            return [SortDescriptor(\PitcherSeason.stat.outs, order: .reverse)]
        case "gamesPitched":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesPitched,
                    order: .reverse
                )
            ]
        case "completeGames":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.completeGames,
                    order: .reverse
                )
            ]
        case "shutouts":
            return [
                SortDescriptor(\PitcherSeason.stat.shutouts, order: .reverse)
            ]
        case "strikes":
            return [
                SortDescriptor(\PitcherSeason.stat.strikes, order: .reverse)
            ]
        case "strikePercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikePercentage,
                    order: .reverse
                )
            ]
        case "hitBatsmen":
            return [
                SortDescriptor(\PitcherSeason.stat.hitBatsmen, order: .reverse)
            ]
        case "balks":
            return [SortDescriptor(\PitcherSeason.stat.balks, order: .reverse)]
        case "wildPitches":
            return [
                SortDescriptor(\PitcherSeason.stat.wildPitches, order: .reverse)
            ]
        case "pickoffs":
            return [
                SortDescriptor(\PitcherSeason.stat.pickoffs, order: .reverse)
            ]
        case "totalBases":
            return [
                SortDescriptor(\PitcherSeason.stat.totalBases, order: .forward)
            ]
        case "groundOutsToAirouts":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.groundOutsToAirouts,
                    order: .reverse
                )
            ]
        case "winPercentage":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.winPercentage,
                    order: .reverse
                )
            ]
        case "pitchesPerInning":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.pitchesPerInning,
                    order: .forward
                )
            ]
        case "gamesFinished":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.gamesFinished,
                    order: .reverse
                )
            ]
        case "strikeoutWalkRatio":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeoutWalkRatio,
                    order: .reverse
                )
            ]
        case "strikeoutsPer9Inn":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.strikeoutsPer9Inn,
                    order: .reverse
                )
            ]
        case "walksPer9Inn":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.walksPer9Inn,
                    order: .forward
                )
            ]
        case "hitsPer9Inn":
            return [
                SortDescriptor(\PitcherSeason.stat.hitsPer9Inn, order: .forward)
            ]
        case "runsScoredPer9":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.runsScoredPer9,
                    order: .forward
                )
            ]
        case "homeRunsPer9":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.homeRunsPer9,
                    order: .forward
                )
            ]
        case "inheritedRunners":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inheritedRunners,
                    order: .reverse
                )
            ]
        case "inheritedRunnersScored":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.inheritedRunnersScored,
                    order: .reverse
                )
            ]
        case "catchersInterference":
            return [
                SortDescriptor(
                    \PitcherSeason.stat.catchersInterference,
                    order: .reverse
                )
            ]
        case "sacBunts":
            return [
                SortDescriptor(\PitcherSeason.stat.sacBunts, order: .reverse)
            ]
        case "sacFlies":
            return [
                SortDescriptor(\PitcherSeason.stat.sacFlies, order: .reverse)
            ]
        default:
            return [SortDescriptor(\PitcherSeason.stat.era, order: .forward)]
        }
    }
}
