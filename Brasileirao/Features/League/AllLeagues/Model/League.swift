//
//  League.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct League: Codable {
    public private (set) var id: Int?
    public private (set) var name: String?
    public private (set) var type: String?
    public private (set) var edition: Int?
    public private (set) var seasonStart: String?
    public private (set) var seasonEnd: String?
    public private (set) var flagURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "league_id"
        case name = "name"
        case type = "type"
        case edition = "season"
        case seasonStart = "season_start"
        case seasonEnd = "season_end"
        case flagURL = "flag"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.edition = try container.decodeIfPresent(Int.self, forKey: .edition)
        self.seasonStart = try container.decodeIfPresent(String.self, forKey: .seasonStart)
        self.seasonEnd = try container.decodeIfPresent(String.self, forKey: .seasonEnd)
        self.flagURL = try container.decodeIfPresent(String.self, forKey: .seasonEnd)
    }
}

