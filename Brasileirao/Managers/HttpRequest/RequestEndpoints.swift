//
//  RequestEndpoints.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

enum RequestEndpoints {
    case leagueInfo(_ league: Leagues)
    case simulatedLeagueStandings(_ league: Leagues)
    case leagueStandings(_ league: Leagues)
    case fixtures(_ league: Leagues)
    case fixturesStatistics(_ fixtureId: String)
    case lineups(_ fixtureId: String)
    case topScores(_ leagueId: String)
    case teamFixtures(_ teamId: String)
    case teamNext10Fixtures(_ teamId: String)
    case fixtureEvents(_ fixtureId: String)
    
    var forLeague: Leagues? {
        switch self {
        case .leagueInfo(let league),
             .leagueStandings(let league),
             .fixtures(let league):
            return league
        default:
            return nil
        }
    }
    
    var endPoint: String {
        switch self {
        case .leagueInfo(let league):
            return "leagues/league/\(league.rawValue)"
        case .leagueStandings(let league):
            return "v2/leagueTable/\(league.rawValue)"
        case .fixtures(let league):
            return "v2/fixtures/league/\(league.rawValue)"
        case .fixturesStatistics(let fixtureId): //Need to insert fixture ID
            return "v2/statistics/fixture/\(fixtureId)"
        case .lineups(let fixtureId):
            return "v2/lineups/\(fixtureId)"
        case .topScores(let leagueId): //Need to insert league ID
            return "v2/topscorers/\(leagueId)"
        case .teamFixtures(let id):
            return "v2/fixtures/team/\(id)" //Need to insert team ID
        case .teamNext10Fixtures(let teamId):
            return "fixtures/team/\(teamId)/next/10"
        case .fixtureEvents(let fixtureId):
            return "v2/events/\(fixtureId)"
        default:
            return ""
        }
    }
    
    var url: String {
        return "https://api-football-v1.p.rapidapi.com/"
    }
    
    var completePath: String {
        return "\(self.url)\(self.endPoint)"
    }
    
    var mockJson: String {
        switch self {
        case .leagueInfo:
            return "campeonato_brasileiro"
        case .leagueStandings:
            return "standings"
        case .fixtures:
            return "fixtures"
        case .fixturesStatistics:
            return "fixturesStats"
        case .lineups:
            return "lineups"
        case .topScores:
            return "topScores"
        case .teamFixtures:
            return "teamFixtures"
        case .teamNext10Fixtures:
            return "teamNext10Fixtures"
        case .fixtureEvents:
            return "fixtureEvents"
        default:
            return ""
        }
    }

    var coreDataTable: String {
        switch self {
        case .leagueInfo:
            return "campeonato_brasileiro"
        case .leagueStandings:
            return "Standings"
        case .fixtures:
            return "Fixtures"
        case .fixturesStatistics:
            return "FixtureStats"
        case .lineups:
            return "Lineups"
        case .topScores:
            return "TopScores"
        case .teamFixtures:
            return "TeamFixtures"
        case .teamNext10Fixtures:
            return "TeamNext10Fixtures"
        case .fixtureEvents:
            return "FixtureEvents"
        case .simulatedLeagueStandings:
            return "SimulatedStandings"
        }
    }
}
