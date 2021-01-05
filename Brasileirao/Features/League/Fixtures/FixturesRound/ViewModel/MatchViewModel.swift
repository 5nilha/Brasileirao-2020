//
//  MatchViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct MatchViewModel {
    
    var league: Leagues = .brazilian
    private let match: Match
    private let calendar = Calendar.current
    
    init(match: Match) {
        self.match = match
    }
    
    var id: String? {
        guard let id = match.id else { return nil}
        return "\(id)"
    }
    
    var round: Int? {
        guard let matchRound = match.round, let numeralRound = Int(matchRound.onlyNumbers)else { return nil}
        return numeralRound
    }
    
    var leagueId: String? {
        guard let id = match.leagueId else { return nil}
        return "\(id)"
    }
    
    var homeTeam: String? {
        guard let name = match.homeTeam?.name else { return nil}
        return "\(name)"
    }
    
    var homeTeamId: String? {
        guard let id = match.homeTeam?.id else { return nil}
        return "\(id)"
    }
    
    var homeTeamLogoUrl: URL? {
        guard let urlString = match.homeTeam?.logoURL,
              let url = URL(string: urlString) else { return nil}
        return url
    }
    
    var awayTeam: String? {
        guard let name = match.awayTeam?.name else { return nil}
        return "\(name)"
    }
    
    var awayTeamId: String? {
        guard let id = match.awayTeam?.id else { return nil}
        return "\(id)"
    }
    
    var awayTeamLogoUrl: URL? {
        guard let urlString = match.awayTeam?.logoURL,
              let url = URL(string: urlString) else { return nil}
        return url
    }
    
    var scoreHomeTeam: String {
        guard let score = match.scoreHomeTeam else { return "" }
        return "\(score)"
    }
    
    var scoreAwayTeam: String {
        guard let score = match.scoreAwayTeam else { return "" }
        return "\(score)"
    }
    
    var status: String? {
        return match.status
    }
    
    var gameDate: String? {
        return match.gameDate
    }
    
    var formattedDate: String? {
        return date?.formattedDateString.capitalized
    }
    
    var gameTime: String? {
        return date?.militaryTime
    }

    var date: Date? {
        guard let matchTimestamp = match.gameTimestamp else { return nil }
        return Date(timeIntervalSince1970: Double (matchTimestamp))
    }
    
    func editScore(homeTeamScore: String, awayTeamScore: String) {
        guard let homeScore = Int16(homeTeamScore),
              let awayScore = Int16(awayTeamScore)
        else {
            return
        }
        self.match.updateFixture(homeTeamScore: homeScore, awayTeamScore: awayScore)
        let league = MainManager.shared.currentLeague
        _ = DatabaseHelper.updateFixture(match: self.match, endPoint: .fixtures(league))
        guard let standingTable = MainManager.shared.campeonatoBrasileiroHelper.standingTable else {
            return
            
        }
        for teamStanding in standingTable {
            if teamStanding.team == homeTeam {
                _ = teamStanding.updateStanding(goalsFor: homeScore, goalsAgainst: awayScore, for: league)
            } else if teamStanding.team == awayTeam {
                _ = teamStanding.updateStanding(goalsFor: awayScore, goalsAgainst: homeScore, for: league)
            }
        }
    }
}
