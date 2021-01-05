//
//  TeamStanding.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

class TeamStanding: Codable {
    
    public private (set) var id: Int64?
    public private (set) var position: Int16?
    public private (set) var teamName: String?
    public private (set) var teamLogo: String?
    public private (set) var points: Int16?
    public private (set) var goalsDifference: Int16?
    public private (set) var lastGames: String?
    public private (set) var group: String?
    public private (set) var lastUpdate: String?
    public private (set) var rankDescription: String?
    public private (set) var allGames: TeamStandingAllGames?
    
    enum CodingKeys: String, CodingKey {
        case id = "team_id"
        case position = "rank"
        case teamName = "teamName"
        case teamLogo = "logo"
        case points = "points"
        case goalsDifference = "goalsDiff"
        case lastGames = "forme"
        case group = "group"
        case lastUpdate = "lastUpdate"
        case rankDescription = "description"
        case allGames = "all"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.position = try container.decodeIfPresent(Int16.self, forKey: .position)
        self.teamName = try container.decodeIfPresent(String.self, forKey: .teamName)
        self.teamLogo = try container.decodeIfPresent(String.self, forKey: .teamLogo)
        self.points = try container.decodeIfPresent(Int16.self, forKey: .points)
        self.goalsDifference = try container.decodeIfPresent(Int16.self, forKey: .goalsDifference)
        self.lastGames = try container.decodeIfPresent(String.self, forKey: .lastGames)
        self.group = try container.decodeIfPresent(String.self, forKey: .group)
        self.lastUpdate = try container.decodeIfPresent(String.self, forKey: .lastUpdate)
        self.rankDescription = try container.decodeIfPresent(String.self, forKey: .rankDescription)
        self.allGames = try container.decodeIfPresent(TeamStandingAllGames.self, forKey: .allGames)
    }
    
    init(_ standing: Standings) {
        self.id = standing.teamId
        self.position = standing.position
        self.teamName = standing.teamName
        self.teamLogo = standing.teamLogo
        self.points = standing.points
        self.goalsDifference = standing.goalsDifference
        self.lastGames = standing.lastGames
        self.group = standing.group
        self.lastUpdate = standing.lastUpdate
        self.rankDescription = standing.rankDescription
        
        self.allGames = TeamStandingAllGames()
        self.allGames?.matchsPlayed = standing.matchesPlayed
        self.allGames?.win = standing.win
        self.allGames?.draw = standing.draw
        self.allGames?.lose = standing.lose
        self.allGames?.goalsFor = standing.goalsFor
        self.allGames?.goalsAgainst = standing.goalsAgainst
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(position, forKey: .position)
        try container.encode(teamName, forKey: .teamName)
        try container.encode(teamLogo, forKey: .teamLogo)
        try container.encode(points, forKey: .points)
        try container.encode(goalsDifference, forKey: .goalsDifference)
        try container.encode(lastGames, forKey: .lastGames)
        try container.encode(group, forKey: .group)
        try container.encode(lastUpdate, forKey: .lastUpdate)
        try container.encode(rankDescription, forKey: .rankDescription)
    }
    
    func updateTeamStanding(goalsFor: Int16, goalsAgainst: Int16) {
        var allGames = self.allGames
        allGames?.goalsFor = (self.allGames?.goalsFor ?? 0) + goalsFor
        allGames?.goalsAgainst = (self.allGames?.goalsAgainst ?? 0) + goalsFor
        allGames?.matchsPlayed = (self.allGames?.matchsPlayed ?? 0) + goalsFor
        self.goalsDifference = (allGames?.goalsFor ?? 0) - (allGames?.goalsAgainst ?? 0)
        
        var points = self.points ?? 0
        if goalsFor > goalsAgainst {
            points += 3
            allGames?.win = (self.allGames?.win ?? 0) + 1
        } else if goalsFor < goalsAgainst {
            allGames?.lose = (self.allGames?.lose ?? 0) + 1
        } else {
            points += 1
            allGames?.draw = (self.allGames?.draw ?? 0) + 1
        }
        self.points = points
        self.allGames = allGames
    }
}

struct TeamStandingAllGames: Codable {
    public fileprivate (set) var matchsPlayed: Int16?
    public fileprivate (set) var win: Int16?
    public fileprivate (set) var draw: Int16?
    public fileprivate (set) var lose: Int16?
    public fileprivate (set) var goalsFor: Int16?
    public fileprivate (set) var goalsAgainst: Int16?
    
    enum CodingKeys: String, CodingKey {
        case matchsPlayed
        case win
        case draw
        case lose
        case goalsFor
        case goalsAgainst
    }

    init(){}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matchsPlayed = try container.decodeIfPresent(Int16.self, forKey: .matchsPlayed)
        self.win = try container.decodeIfPresent(Int16.self, forKey: .win)
        self.draw = try container.decodeIfPresent(Int16.self, forKey: .draw)
        self.lose = try container.decodeIfPresent(Int16.self, forKey: .lose)
        self.goalsFor = try container.decodeIfPresent(Int16.self, forKey: .goalsFor)
        self.goalsAgainst = try container.decodeIfPresent(Int16.self, forKey: .goalsAgainst)
    }
}
