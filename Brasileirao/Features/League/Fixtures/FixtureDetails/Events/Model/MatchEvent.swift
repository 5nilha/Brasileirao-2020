//
//  MatchEvent.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/14/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct MatchEvent: Codable {
    public private (set) var elapsed: Int16?
    public private (set) var teamId: Int64?
    public private (set) var teamName: String?
    public private (set) var playerId: Int64?
    public private (set) var playerName: String?
    public private (set) var assistId: Int64?
    public private (set) var assistName: String?
    public private (set) var type: String?
    public private (set) var detail: String?
    
    enum CodingKeys: String, CodingKey {
        case elapsed = "elapsed"
        case teamId = "team_id"
        case teamName = "teamName"
        case playerId = "player_id"
        case playerName = "player"
        case assistId = "assist_id"
        case assistName = "assist"
        case type = "type"
        case detail = "detail"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.elapsed = try container.decodeIfPresent(Int16.self, forKey: .elapsed)
        self.teamId = try container.decodeIfPresent(Int64.self, forKey: .teamId)
        self.teamName = try container.decodeIfPresent(String.self, forKey: .teamName)
        self.playerId = try container.decodeIfPresent(Int64.self, forKey: .playerId)
        self.playerName = try container.decodeIfPresent(String.self, forKey: .playerName)
        self.assistId = try container.decodeIfPresent(Int64.self, forKey: .assistId)
        self.assistName = try container.decodeIfPresent(String.self, forKey: .assistName)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.detail = try container.decodeIfPresent(String.self, forKey: .detail)
    }
    
    init(_ event: FixtureEvents) {
        self.elapsed = event.elapsed
        self.teamId = event.teamId
        self.teamName = event.teamName
        self.playerId = event.playerId
        self.playerName = event.playerName
        self.assistId = event.assistId
        self.assistName = event.assistName
        self.type = event.type
        self.detail = event.detail
    }

}
