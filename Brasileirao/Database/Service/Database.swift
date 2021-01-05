//
//  Database.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/15/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation
import CoreData

class Database {
    
    class func getContext () -> NSManagedObjectContext {
        return Database.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
            //The container that holds both data model entities
            let container = NSPersistentContainer(name: "Futebol")

            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */

                    Logger.log(error: error, info: "Error trying to load persistent stores for CoreData. \(error.userInfo)")
                    return
                }
            })
            return container
        }()
    
    // MARK: - Core Data Saving support
        class func saveContext() {
            let context = self.getContext()
            if context.hasChanges {
                do {
                    try context.save()
                    Logger.logSuccess(title: "Data Saved", description: "Data Saved to Context")
                } catch {
                    let nserror = error as NSError
                    Logger.log(error: error, info: "Error Trying to Save Data to Core Data Context. Error: \(nserror.userInfo)")
                }
            }
        }
    
    /*MARK: CRUD Operations */
    // Save the data in Database
    class func saveData() -> Bool {
        let context = Database.getContext()
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nserror = error as NSError
                Logger.log(error: error, info: "Error Trying to Save Data to Core Data Table. Error: \(nserror.userInfo)")
                return false
            }
        }
        return false
    }
    
    //Update Data
//        class func update(request: NSFetchRequest<NSManagedObject>, data: [String: Any]) -> Bool {
//            let success: Bool = true
//            let requested = request
//            do {
//                let fetched = try Database.getContext().fetch(requested)
//
//                guard let objectUpdate = fetched.first as? NSManagedObject else { return false }
//                for (key, value) in data {
//                    objectUpdate.setValue(key, forKey: value)
//                }
//
//                do {
//                    try Database.getContext().save()
//                }
//                catch {
//                    Logger.log(error: error, info: "Error trying to Update data.")
//                    return !success
//                }
//
//                return success
//            } catch let error as NSError{
//                Logger.log(error: error, info: "Error trying to Update data. \(error.userInfo)")
//                return !success
//            }
//        }

    
    // Delete ALL Table content From CoreData
    class func deleteAll(from endpoint: RequestEndpoints) {
        do {
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: endpoint.coreDataTable)
            let deleteALL = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            try Database.getContext().execute(deleteALL)
            Database.saveContext()
        } catch {
            print ("There is an error in deleting records")
        }
    }
    
    class func delete(request: NSFetchRequest<NSManagedObject>) -> Bool {
        let success: Bool = true
        let requested = request
        do {
            let fetched = try Database.getContext().fetch(requested)
            for data in fetched {
                Database.getContext().delete(data)
            }
            return success
        } catch let error as NSError{
            Logger.log(error: error, info: "Error trying to delete data. \(error.userInfo)")
            return !success
        }
    }
    
    class func fetchData(request: NSFetchRequest<NSManagedObject>) -> [NSManagedObject]? {
   
        let context = Database.getContext()
        do {
            let events = try context.fetch(request)
            return events
        }
        catch let error as NSError {
            Logger.log(error: error, info: "Error trying to fetch Fixture events from Core Data. \(error.userInfo)")
            return nil
        }
    }
    
}
