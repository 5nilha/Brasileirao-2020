//
//  Team.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct Team: Codable {
    public private (set) var id: Int64?
    public private (set) var name: String?
    public private (set) var logoURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "team_id"
        case name = "team_name"
        case logoURL = "logo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.logoURL = try container.decodeIfPresent(String.self, forKey: .logoURL)
    }
    
    init(_ team: Teams) {
        self.id = team.id
        self.name = team.name
        self.logoURL = team.logoURL
    }
    
    init(id: Int64?, name: String?, logoURL: String?) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
    }
}
