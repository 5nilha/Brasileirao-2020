//
//  MatchStats.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct MatchStats: Codable {
    public private (set) var shotsOnGoal: Stat?
    public private (set) var totalShots: Stat?
    public private (set) var fouls: Stat?
    public private (set) var offsides: Stat?
    public private (set) var corners: Stat?
    public private (set) var ballPossession: Stat?
    public private (set) var yellowCards: Stat?
    public private (set) var redCards: Stat?
    public private (set) var totalPasses: Stat?
    
    enum CodingKeys: String, CodingKey {
        case shotsOnGoal = "Shots on Goal"
        case totalShots = "Total Shots"
        case fouls = "Fouls"
        case offsides = "Offsides"
        case corners = "Corner Kicks"
        case ballPossession = "Ball Possession"
        case yellowCards = "Yellow Cards"
        case redCards = "Red Cards"
        case totalPasses = "Total passes"
    }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.shotsOnGoal = try container.decodeIfPresent(Stat.self, forKey: .shotsOnGoal)
        self.totalShots = try container.decodeIfPresent(Stat.self, forKey: .totalShots)
        self.fouls = try container.decodeIfPresent(Stat.self, forKey: .fouls)
        self.offsides = try container.decodeIfPresent(Stat.self, forKey: .offsides)
        self.corners = try container.decodeIfPresent(Stat.self, forKey: .corners)
        self.ballPossession = try container.decodeIfPresent(Stat.self, forKey: .ballPossession)
        self.yellowCards = try container.decodeIfPresent(Stat.self, forKey: .yellowCards)
        self.redCards = try container.decodeIfPresent(Stat.self, forKey: .redCards)
        self.totalPasses = try container.decodeIfPresent(Stat.self, forKey: .totalPasses)
    }
    
    init(_ stats: FixtureStats) {
        self.shotsOnGoal = Stat(home: stats.shotsOnGoalHome, away: stats.shotsOnGoalAway)
        self.totalShots = Stat(home: stats.totalShotsHome, away: stats.totalShotsAway)
        self.fouls = Stat(home: stats.foulsHome, away: stats.foulsAway)
        self.offsides = Stat(home: stats.offsidesHome, away: stats.offsidesAway)
        self.corners = Stat(home: stats.cornersHome, away: stats.cornersAway)
        self.ballPossession = Stat(home: stats.ballPossessionHome, away: stats.ballPossessionAway)
        self.yellowCards = Stat(home: stats.yellowCardsHome, away: stats.yellowCardsAway)
        self.redCards = Stat(home: stats.redCardsHome, away: stats.redCardsAway)
        self.totalPasses = Stat(home: stats.totalPassesHome, away: stats.totalPassesAway)
    }
}

struct Stat: Codable, FixturesStatsProtocol {
    public private (set) var home: String?
    public private (set) var away: String?
    
    enum CodingKeys: String, CodingKey {
        case home
        case away
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.home = try container.decodeIfPresent(String.self, forKey: .home)
        self.away = try container.decodeIfPresent(String.self, forKey: .away)
    }
    
    init(home: String?, away: String?) {
        self.home = home
        self.away = away
    }
}
