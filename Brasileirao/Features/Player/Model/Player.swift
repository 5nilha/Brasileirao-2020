//
//  Player.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct Player: Codable {
    public private (set) var player: String?
    public private (set) var number: String?
    
    enum CodingKeys: String, CodingKey {
        case player
        case number
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.player = try container.decodeIfPresent(String.self, forKey: .player)
        self.number = try container.decodeIfPresent(String.self, forKey: .number)
        
    }
}
