//
//  FixtureEvents+CoreDataProperties.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//
//

import Foundation
import CoreData


extension FixtureEvents {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FixtureEvents> {
        return NSFetchRequest<FixtureEvents>(entityName: "FixtureEvents")
    }

    @NSManaged public var fixtureId: Int64
    @NSManaged public var elapsed: Int16
    @NSManaged public var teamId: Int64
    @NSManaged public var teamName: String?
    @NSManaged public var playerId: Int64
    @NSManaged public var playerName: String?
    @NSManaged public var assistId: Int64
    @NSManaged public var assistName: String?
    @NSManaged public var type: String?
    @NSManaged public var detail: String?
    
    func setEvent(fixtureId: Int64, event: MatchEvent) {
        self.fixtureId = fixtureId 
        self.elapsed = event.elapsed ?? 0
        self.teamId = event.teamId ?? 0
        self.teamName = event.teamName ?? ""
        self.playerId = event.playerId ?? 0
        self.playerName = event.playerName ?? ""
        self.assistId = event.assistId ?? 0
        self.assistName = event.assistName
        self.type = event.type ?? ""
        self.detail = event.detail ?? ""
    }
    
    class func fetchData(fixtureId: Int64, endpoint: RequestEndpoints) -> [FixtureEvents]? {
   
        let context = Database.getContext()
        let dataFetchRequest = NSFetchRequest<FixtureEvents>(entityName: endpoint.coreDataTable)
        
        dataFetchRequest.predicate = NSPredicate(format: "fixtureId == %i", fixtureId)
        
        do {
            let events = try context.fetch(dataFetchRequest)
            return events
        }
        catch let error as NSError {
            Logger.log(error: error, info: "Error trying to fetch Fixture events of id: \(fixtureId) from Core Data. \(error.userInfo)")
            return nil
        }
    }
}
