//
//  Fixtures+CoreDataProperties.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//
//

import Foundation
import CoreData


extension Fixtures {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fixtures> {
        return NSFetchRequest<Fixtures>(entityName: "Fixtures")
    }

    @NSManaged public var id: Int64
    @NSManaged public var leagueId: Int64
    @NSManaged public var round: String?
    @NSManaged public var scoreHomeTeam: String?
    @NSManaged public var scoreAwayTeam: String?
    @NSManaged public var status: String?
    @NSManaged public var gameTimestamp: Int64
    @NSManaged public var gameDate: String?
    @NSManaged public var homeTeamId: Int64
    @NSManaged public var awayTeamId: Int64
    
    func setFixture(fixture: Match) {
        self.id = fixture.id ?? 0
        self.leagueId = fixture.leagueId ?? 0
        self.round = fixture.round
        self.status = fixture.status ?? ""
        self.gameTimestamp = fixture.gameTimestamp ?? 0
        self.gameDate = fixture.gameDate
        self.homeTeamId = fixture.homeTeam?.id ?? 0
        self.awayTeamId = fixture.awayTeam?.id ?? 0
        
        if let homeScore = fixture.scoreHomeTeam { self.scoreHomeTeam = "\(homeScore)" }
        if let awayScore = fixture.scoreAwayTeam { self.scoreAwayTeam = "\(awayScore)" }
    }
    
    func updateFixture(match: Match) {
        if let homeScore = match.scoreHomeTeam { self.scoreHomeTeam = "\(homeScore)" }
        if let awayScore = match.scoreAwayTeam { self.scoreAwayTeam = "\(awayScore)" }
    }
}

extension Fixtures : Identifiable {

}
