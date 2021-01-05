//
//  FixtureStats+CoreDataProperties.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//
//

import Foundation
import CoreData


extension FixtureStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FixtureStats> {
        return NSFetchRequest<FixtureStats>(entityName: "FixtureStats")
    }

    @NSManaged public var ballPossessionAway: String?
    @NSManaged public var ballPossessionHome: String?
    @NSManaged public var cornersAway: String?
    @NSManaged public var cornersHome: String?
    @NSManaged public var fixtureId: Int64
    @NSManaged public var foulsAway: String?
    @NSManaged public var foulsHome: String?
    @NSManaged public var offsidesAway: String?
    @NSManaged public var offsidesHome: String?
    @NSManaged public var redCardsAway: String?
    @NSManaged public var redCardsHome: String?
    @NSManaged public var shotsOnGoalAway: String?
    @NSManaged public var shotsOnGoalHome: String?
    @NSManaged public var totalPassesAway: String?
    @NSManaged public var totalPassesHome: String?
    @NSManaged public var totalShotsAway: String?
    @NSManaged public var totalShotsHome: String?
    @NSManaged public var yellowCardsAway: String?
    @NSManaged public var yellowCardsHome: String?

    
    func setStat(fixtureId: Int64, matchStats: MatchStats) {
        self.fixtureId = fixtureId
        self.shotsOnGoalHome = matchStats.shotsOnGoal?.home ?? ""
        self.shotsOnGoalAway = matchStats.shotsOnGoal?.away ?? ""
        self.totalShotsHome = matchStats.totalShots?.home ?? ""
        self.totalShotsAway = matchStats.totalShots?.away ?? ""
        self.foulsHome = matchStats.fouls?.home ?? ""
        self.foulsAway = matchStats.fouls?.away ?? ""
        self.offsidesHome = matchStats.offsides?.home ?? ""
        self.offsidesAway = matchStats.offsides?.away ?? ""
        self.cornersHome = matchStats.corners?.home ?? ""
        self.cornersAway = matchStats.corners?.away ?? ""
        self.ballPossessionHome = matchStats.ballPossession?.home ?? ""
        self.ballPossessionAway = matchStats.ballPossession?.away ?? ""
        self.yellowCardsHome = matchStats.yellowCards?.home ?? ""
        self.yellowCardsAway = matchStats.yellowCards?.away ?? ""
        self.redCardsHome = matchStats.redCards?.home ?? ""
        self.redCardsAway = matchStats.redCards?.away ?? ""
        self.totalPassesHome = matchStats.totalPasses?.home ?? ""
        self.totalPassesAway = matchStats.totalPasses?.away ?? ""
    }
}

extension FixtureStats : Identifiable {

}
