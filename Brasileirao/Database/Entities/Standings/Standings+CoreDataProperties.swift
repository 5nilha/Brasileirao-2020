//
//  Standings+CoreDataProperties.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//
//

import Foundation
import CoreData


extension Standings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Standings> {
        return NSFetchRequest<Standings>(entityName: "Standings")
    }

    @NSManaged public var teamId: Int64
    @NSManaged public var leagueId: Int64
    @NSManaged public var position: Int16
    @NSManaged public var teamName: String?
    @NSManaged public var teamLogo: String?
    @NSManaged public var points: Int16
    @NSManaged public var goalsDifference: Int16
    @NSManaged public var lastGames: String?
    @NSManaged public var group: String?
    @NSManaged public var lastUpdate: String?
    @NSManaged public var rankDescription: String?
    @NSManaged public var matchesPlayed: Int16
    @NSManaged public var win: Int16
    @NSManaged public var draw: Int16
    @NSManaged public var lose: Int16
    @NSManaged public var goalsFor: Int16
    @NSManaged public var goalsAgainst: Int16
    
    func setStanding(leagueId: Int64, teamStanding: TeamStanding) {
        self.teamId = teamStanding.id ?? 0
        self.leagueId = leagueId
        self.position = teamStanding.position ?? 0
        self.teamName = teamStanding.teamName
        self.teamLogo = teamStanding.teamLogo
        self.points = teamStanding.points ?? 0
        self.goalsDifference = teamStanding.goalsDifference ?? 0
        self.lastGames = teamStanding.lastGames
        self.group = teamStanding.group
        self.lastUpdate = teamStanding.lastUpdate
        self.rankDescription = teamStanding.rankDescription
        self.matchesPlayed = teamStanding.allGames?.matchsPlayed ?? 0
        self.win = teamStanding.allGames?.win ?? 0
        self.draw = teamStanding.allGames?.draw ?? 0
        self.lose = teamStanding.allGames?.lose ?? 0
        self.goalsFor = teamStanding.allGames?.goalsFor ?? 0
        self.goalsAgainst = teamStanding.allGames?.goalsAgainst ?? 0
    }
    
    func updatingStanding(teamStanding: TeamStanding) {
        self.points = teamStanding.points ?? 0
        self.goalsDifference = teamStanding.goalsDifference ?? 0
        self.matchesPlayed = teamStanding.allGames?.matchsPlayed ?? 0
        self.win = teamStanding.allGames?.win ?? 0
        self.draw = teamStanding.allGames?.draw ?? 0
        self.lose = teamStanding.allGames?.lose ?? 0
        self.goalsFor = teamStanding.allGames?.goalsFor ?? 0
        self.goalsAgainst = teamStanding.allGames?.goalsAgainst ?? 0
    }
    
}

extension Standings : Identifiable {

}
