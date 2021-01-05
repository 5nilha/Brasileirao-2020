//
//  MatchStatsViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct MatchStatsViewModel {
    
    private var matchStats: MatchStats?
    public private (set) var stats = [(title: String, homeTeam: String, awaysTeam: String)]()
    
    init(matchStats: MatchStats) {
        self.matchStats = matchStats
        self.stats.append(shotsOnGoal)
        self.stats.append(totalShots)
        self.stats.append(fouls)
        self.stats.append(offsides)
        self.stats.append(corners)
        self.stats.append(ballPossession)
        self.stats.append(yellowCards)
        self.stats.append(redCards)
        self.stats.append(totalPasses)
    }
    
    var shotsOnGoal: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "shot_to_goal".localized
        let homeTeamStat = matchStats?.shotsOnGoal?.home ?? "0"
        let awayTeamStat = matchStats?.shotsOnGoal?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }

    var totalShots: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "total_shots".localized
        let homeTeamStat = matchStats?.totalShots?.home ?? "0"
        let awayTeamStat = matchStats?.totalShots?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var fouls: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "fouls".localized
        let homeTeamStat = matchStats?.fouls?.home ?? "0"
        let awayTeamStat = matchStats?.fouls?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var offsides: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "offsides".localized
        let homeTeamStat = matchStats?.offsides?.home ?? "0"
        let awayTeamStat = matchStats?.offsides?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var corners: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "corners".localized
        let homeTeamStat = matchStats?.corners?.home ?? "0"
        let awayTeamStat = matchStats?.corners?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var ballPossession: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "ball_possession".localized
        let homeTeamStat = matchStats?.ballPossession?.home ?? "0"
        let awayTeamStat = matchStats?.ballPossession?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var yellowCards: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "yellow_cards".localized
        let homeTeamStat = matchStats?.yellowCards?.home ?? "0"
        let awayTeamStat = matchStats?.yellowCards?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var redCards: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "red_cards".localized
        let homeTeamStat = matchStats?.redCards?.home ?? "0"
        let awayTeamStat = matchStats?.redCards?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
    
    var totalPasses: (title: String, homeTeam: String, awaysTeam: String) {
        let title = "total_passes".localized
        let homeTeamStat = matchStats?.totalPasses?.home ?? "0"
        let awayTeamStat = matchStats?.totalPasses?.away ?? "0"
        return (title, homeTeamStat, awayTeamStat)
    }
}
