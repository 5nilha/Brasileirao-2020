//
//  Table.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

final class TeamStanding: Decodable {
    public private (set) var position: Int?
    public private (set) var positionVariation: Int?
    public private (set) var overall: Double?
    public private (set) var points: Int?
    public private (set) var matchesPlayed: Int?
    public private (set) var won: Int?
    public private (set) var draw: Int?
    public private (set) var loss: Int?
    public private (set) var goalsFor: Int?
    public private (set) var goalsAgainst: Int?
    public private (set) var goalsDifference: Int?
    public private (set) var goalsAveragePerGame: Double?
    public private (set) var lastGames: [String]?
    public private (set) var team: Team?
    
    enum CodingKeys: String, CodingKey {
        case position = "posicao"
        case positionVariation = "variacao_posicao"
        case overall = "aproveitamento"
        case points = "pontos"
        case matchesPlayed = "jogos"
        case won = "vitorias"
        case draw = "empates"
        case loss = "derrotas"
        case goalsFor = "gols_pro"
        case goalsAgainst = "gols_contra"
        case goalsDifference = "saldo_gols"
        case lastGames = "ultimos_jogos"
        case team = "time"
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.positionVariation = try container.decodeIfPresent(Int.self, forKey: .positionVariation)
        self.overall = try container.decodeIfPresent(Double.self, forKey: .overall)
        self.points = try container.decodeIfPresent(Int.self, forKey: .points)
        self.matchesPlayed = try container.decodeIfPresent(Int.self, forKey: .matchesPlayed)
        self.won = try container.decodeIfPresent(Int.self, forKey: .won)
        self.draw = try container.decodeIfPresent(Int.self, forKey: .draw)
        self.loss = try container.decodeIfPresent(Int.self, forKey: .loss)
        self.goalsFor = try container.decodeIfPresent(Int.self, forKey: .goalsFor)
        self.goalsAgainst = try container.decodeIfPresent(Int.self, forKey: .goalsAgainst)
        self.goalsDifference = try container.decodeIfPresent(Int.self, forKey: .goalsDifference)
        self.lastGames = try container.decodeIfPresent([String].self, forKey: .lastGames)
        self.team = try container.decodeIfPresent(Team.self, forKey: .team)
        
        if let goalsFor = self.goalsFor,
           let matchesPlayed = self.matchesPlayed {
            self.goalsAveragePerGame = Double(goalsFor) / Double(matchesPlayed)
        }
    }
}
