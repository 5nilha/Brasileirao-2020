//
//  TeamStandingViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct TeamStandingViewModel {
    
    private var teamStanding: TeamStanding?
    
    init(teamStanding: TeamStanding) {
        self.teamStanding = teamStanding
    }
    
    var teamId: String {
        guard let id = self.teamStanding?.id else { return ""}
        return "\(id)"
    }
    
    var position: String {
        guard let teamPosition = teamStanding?.position else { return ""}
        return "\(teamPosition)"
    }
    
    var points: String {
        return "\(teamStanding?.points ?? 0)"
    }
    
    var matchesPlayed: String {
        return "\(teamStanding?.allGames?.matchsPlayed ?? 0)"
    }
    
    var won: String {
        return "\(teamStanding?.allGames?.win ?? 0)"
    }
    
    var draw: String {
        return "\(teamStanding?.allGames?.draw ?? 0)"
    }
    
    var loss: String {
        return "\(teamStanding?.allGames?.lose ?? 0)"
    }
    
    var goalsFor: String {
        return "\(teamStanding?.allGames?.goalsFor ?? 0)"
    }
    
    var goalsAgainst: String {
        return "\(teamStanding?.allGames?.goalsAgainst ?? 0)"
    }
    
    var goalsDifference: String {
        return "\(teamStanding?.goalsDifference ?? 0)"
    }
    
    var lastGames: [String] {
        guard let lastGamesSeq = teamStanding?.lastGames else { return [String]()}
        return lastGamesSeq.map { (char) -> String in
            return "\(char)"
        }
    }
    var team: String? {
        return teamStanding?.teamName
    }
    
    var teamLogoURL: URL? {
        guard let urlString = teamStanding?.teamLogo else { return nil }
        return URL(string: urlString)
    }
    
    func updateStanding(goalsFor: Int16, goalsAgainst: Int16, for league: Leagues) -> Bool {
        self.teamStanding?.updateTeamStanding(goalsFor: goalsFor, goalsAgainst: goalsAgainst)
        guard let teamStanding = self.teamStanding else { return false }
        return DatabaseHelper.updateStanding(teamStanding: teamStanding, endPoint: .leagueStandings(league))
    }
}
