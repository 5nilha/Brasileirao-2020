//
//  Teams+CoreDataProperties.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//
//

import Foundation
import CoreData


extension Teams {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teams> {
        return NSFetchRequest<Teams>(entityName: "Teams")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var logoURL: String?
    
    func setTeam(team: Team) {
        self.id = team.id ?? 0
        self.name = team.name
        self.logoURL = team.logoURL
    }

}

extension Teams : Identifiable {

}
