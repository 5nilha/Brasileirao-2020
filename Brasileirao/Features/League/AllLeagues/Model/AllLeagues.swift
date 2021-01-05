//
//  AllLeagues.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct AllLeagues: Codable {
    var leagues: [League]?
    var results: Int?
    var standings: [[TeamStanding]]?
    var fixtures: [Match]?
    var fixturesStats: MatchStats?
    var teams: [Team]?
    var lineups: [Lineup]?
    var fixturesEvents: [MatchEvent]?
    
    enum TopLevelCodingKeys: String, CodingKey {
        case api
    }
    
    enum CodingKeys: String, CodingKey {
        case leagues
        case standings
        case results
        case fixtures
        case teams
        case lineups
        case fixturesStats = "statistics"
        case fixturesEvents = "events"
    }
    
    init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: TopLevelCodingKeys.self)
        let container = try topContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .api)
        self.leagues = try? container.decodeIfPresent([League].self, forKey: .leagues)
        self.standings = try container.decodeIfPresent([[TeamStanding]].self, forKey: .standings)
        self.fixtures = try container.decodeIfPresent([Match].self, forKey: .fixtures)
        self.fixturesStats = try container.decodeIfPresent(MatchStats.self, forKey: .fixturesStats)
        self.fixturesEvents = try container.decodeIfPresent([MatchEvent].self, forKey: .fixturesEvents)
        self.teams = try container.decodeIfPresent([Team].self, forKey: .teams)
        self.lineups = try container.decodeIfPresent([Lineup].self, forKey: .lineups)
        self.results = try container.decodeIfPresent(Int.self, forKey: .results)
    }
}
