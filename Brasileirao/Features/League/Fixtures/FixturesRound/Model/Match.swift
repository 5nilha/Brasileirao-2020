//
//  Match.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

final class Match: Codable {
    
    public private (set) var id: Int64?
    public private (set) var leagueId: Int64?
    public private (set) var round: String?
    public private (set) var homeTeam: Team?
    public private (set) var awayTeam: Team?
    public private (set) var scoreHomeTeam: Int16?
    public private (set) var scoreAwayTeam: Int16?
    public private (set) var status: String?
    public private (set) var gameTimestamp: Int64?
    public private (set) var gameDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "fixture_id"
        case leagueId = "league_id"
        case round = "round"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case scoreHomeTeam = "goalsHomeTeam"
        case scoreAwayTeam = "goalsAwayTeam"
        case status = "status"
        case gameTimestamp = "event_timestamp"
        case gameDate = "event_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.leagueId = try container.decodeIfPresent(Int64.self, forKey: .leagueId)
        self.round = try container.decodeIfPresent(String.self, forKey: .round)
        self.homeTeam = try container.decodeIfPresent(Team.self, forKey: .homeTeam)
        self.awayTeam = try container.decodeIfPresent(Team.self, forKey: .awayTeam)
        self.scoreHomeTeam = try container.decodeIfPresent(Int16.self, forKey: .scoreHomeTeam)
        self.scoreAwayTeam = try container.decodeIfPresent(Int16.self, forKey: .scoreAwayTeam)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.gameTimestamp = try container.decodeIfPresent(Int64.self, forKey: .gameTimestamp)
        self.gameDate = try container.decodeIfPresent(String.self, forKey: .gameDate)
    }
    
    init(_ fixture: Fixtures, homeTeam: Team?, awayTeam: Team?) {
        self.id = fixture.id
        self.leagueId = fixture.leagueId
        self.round = fixture.round
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.scoreHomeTeam = Int16(fixture.scoreHomeTeam ?? "")
        self.scoreAwayTeam = Int16(fixture.scoreAwayTeam ?? "")
        self.status = fixture.status
        self.gameTimestamp = fixture.gameTimestamp
        self.gameDate = fixture.gameDate
    }
    
    func updateFixture(homeTeamScore: Int16, awayTeamScore: Int16) {
        self.scoreHomeTeam = homeTeamScore
        self.scoreAwayTeam = awayTeamScore
    }
    
}
