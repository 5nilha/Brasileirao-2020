//
//  Lineup.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct Lineup: Codable {
    public private (set) var coach: String?
    public private (set) var formation: String?
    public private (set) var startXI: [Player]?
    public private (set) var substitutes: [Player]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case coach
        case formation
        case startXI
        case substitutes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coach = try container.decodeIfPresent(String.self, forKey: .coach)
        self.formation = try container.decodeIfPresent(String.self, forKey: .formation)
        self.startXI = try container.decodeIfPresent([Player].self, forKey: .startXI)
        self.substitutes = try container.decodeIfPresent([Player].self, forKey: .substitutes)
    }
}
