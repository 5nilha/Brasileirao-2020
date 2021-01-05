//
//  DatabaseHelper.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation
import CoreData

class DatabaseHelper {
    
    //MARK: ===============  Standing Datababase Helpers =================
    class func createStanding(league: Leagues, teamStanding: TeamStanding) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        guard let leagueId = Int64(league.rawValue)
        else {
            Logger.log(title: "createStanding Error", description: "Error trying to save Standing. Couldn't convert rawValue to Int64")
            return
        }
        let standing = Standings(context: Database.getContext())
        standing.setStanding(leagueId: leagueId, teamStanding: teamStanding)
        let isSaved = Database.saveData()
        if isSaved {
            Logger.logSuccess(title: "Data Saved", description: "Team Standing Saved to Core Data.")
        }
        DatabaseHelper.createTeam(team: Team(id: teamStanding.id, name: teamStanding.teamName, logoURL: teamStanding.teamLogo))
    }
    
    class func updateStanding(teamStanding: TeamStanding, endPoint: RequestEndpoints) -> Bool {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return true
        } else {
            guard let teamId = teamStanding.id
            else {
                Logger.log(title: "updateStanding Error", description: "Error trying to updating League Standing for \(String(describing: endPoint.forLeague?.name)). Couldn't convert rawValue to Int64")
                return false
            }
            let context = Database.getContext()
            
            let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: endPoint.coreDataTable)
            dataFetchRequest.predicate = NSPredicate(format: "teamId == %i", teamId)
            
            do {
                let fetchedData = try context.fetch(dataFetchRequest)
                let objectUpdate = fetchedData.first as? Standings
                objectUpdate?.updatingStanding(teamStanding: teamStanding)
                
                return Database.saveData()
            } catch {
                print(error)
                return false
            }
        }
    }
    
    
    class func getStandings(endPoint: RequestEndpoints, completion: @escaping ([TeamStanding]?) -> ()) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        DispatchQueue.global(qos: .background).async {
            guard let league = endPoint.forLeague,
                  let leagueId = Int64(league.rawValue)
            else {
                Logger.log(title: "getStandings Error", description: "Error trying to Fetch League Standing for \(String(describing: endPoint.forLeague?.name)). Couldn't convert rawValue to Int64")
                completion(nil)
                return
            }
            guard let dataFetchRequest = NSFetchRequest<Standings>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
            else {
                Logger.log(title: "getStandings Error", description: "Error trying to Fetch League Standing for \(String(describing: endPoint.forLeague?.name)). Couldn't convert NSFetchRequest<Fixtures> to NSFetchRequest<NSManagedObject>")
                completion(nil)
                return
            }
            dataFetchRequest.predicate = NSPredicate(format: "leagueId == %i", leagueId)
            guard let standings = Database.fetchData(request: dataFetchRequest) as? [Standings]
            else {
                Logger.log(title: "getStandings Error", description: "Error trying to convert array of NSManagedObject to array of Standings")
                completion(nil)
                return
            }
            
            let standingTable = standings.map({ (teamStanding) -> TeamStanding in
                return TeamStanding(teamStanding)
            })
            DispatchQueue.main.async {
                completion(standingTable)
            }
        }
    }
    
    class func deleteStanding(endPoint: RequestEndpoints)  {
        if let requestType = RequestManager.instance.requestType,
           requestType  == .mock {
            return
        }
        guard let league = endPoint.forLeague,
              let leagueId = Int64(league.rawValue)
        else { return }
        
        guard let requested = NSFetchRequest<Fixtures>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
        else {
            Logger.log(title: "deleteFixtures Error", description: "Error trying to delete all Standings for \(String(describing: endPoint.forLeague?.rawValue)). Couldn't convert NSFetchRequest<Fixtures> to NSFetchRequest<NSManagedObject>")
            return }
        requested.predicate = NSPredicate(format: "leagueId == %i", leagueId)
        _ = Database.delete(request: requested)
    }
    
    //MARK: ===============  Fixtures Datababase Helpers =================
    class func createFixture(fixture: Match) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        let fixtures = Fixtures(context: Database.getContext())
        fixtures.setFixture(fixture: fixture)
        let isSaved = Database.saveData()
        if isSaved {
            Logger.logSuccess(title: "Data Saved", description: "Fixture Saved to Core Data.")
        }
    }
    
    class func updateFixture(match: Match, endPoint: RequestEndpoints) -> Bool {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return false
        }
        guard let fixtureId = match.id
        else {
            Logger.log(title: "updateFixture Error", description: "Error trying to updating League Fixture for \(String(describing: endPoint.forLeague?.name)). Couldn't convert rawValue to Int64")
            return false
        }
        let context = Database.getContext()
        
        let dataFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: endPoint.coreDataTable)
        dataFetchRequest.predicate = NSPredicate(format: "id == %i", fixtureId)
        
        do {
            let fetchedData = try context.fetch(dataFetchRequest)
            let objectUpdate = fetchedData.first as? Fixtures
            objectUpdate?.updateFixture(match: match)
            
            return Database.saveData()
        } catch {
            print(error)
            return false
        }
    }
    
    class func getFixtures(endPoint: RequestEndpoints, completion: @escaping ([Match]?) -> ()) {
        guard let league = endPoint.forLeague,
              let leagueId = Int64(league.rawValue)
        else {
            Logger.log(title: "getFixtures Error", description: "Error trying to Fetch all Fixture for \(String(describing: endPoint.forLeague?.name)). Couldn't convert rawValue to Int64")
            completion(nil)
            return
        }
        guard let dataFetchRequest = NSFetchRequest<Fixtures>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
        else {
            Logger.log(title: "getFixtures Error", description: "Error trying to Fetch all Fixture for \(String(describing: endPoint.forLeague?.name)). Couldn't convert NSFetchRequest<Fixtures> to NSFetchRequest<NSManagedObject>")
            completion(nil)
        }
        dataFetchRequest.predicate = NSPredicate(format: "leagueId == %i", leagueId)
        guard let fixtures = Database.fetchData(request: dataFetchRequest) as? [Fixtures]
        else {
            Logger.log(title: "getFixtures Error", description: "Error trying to convert array of NSManagedObject to array of Fixtures")
            completion(nil)
            return
        }

        guard let teams = try? Database.getContext().fetch(Teams.fetchRequest()) as? [Teams] else {
            completion(nil)
            return
        }
        
        let matches = fixtures.map({ (fixture) -> Match in
            var homeTeam: Team?
            var awayTeam: Team?
            for team in teams {
                if team.id == fixture.homeTeamId {
                    homeTeam = Team(team)
                }
                if team.id == fixture.awayTeamId {
                    awayTeam = Team(team)
                }
            }
            
            return Match(fixture, homeTeam: homeTeam, awayTeam: awayTeam)
        })
        completion(matches)
    }
    
    class func deleteFixtures(endPoint: RequestEndpoints)  {
        guard let league = endPoint.forLeague,
              let leagueId = Int64(league.rawValue)
        else {
            Logger.log(title: "deleteFixtures Error", description: "Error trying to delete all Fixture for \(String(describing: endPoint.forLeague?.rawValue)). Couldn't convert rawValue to Int64")
            return
        }
        guard let requested = NSFetchRequest<Fixtures>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
        else {
            Logger.log(title: "deleteFixtures Error", description: "Error trying to delete all Fixture for \(String(describing: endPoint.forLeague?.rawValue)). Couldn't convert NSFetchRequest<Fixtures> to NSFetchRequest<NSManagedObject>")
            return }
        requested.predicate = NSPredicate(format: "leagueId == %i", leagueId)
        _ = Database.delete(request: requested)
    }
    
    //MARK: ===============  Teams Datababase Helpers =================
    class func getTeam(teamId: Int64) -> Team? {
        guard let teams = try? Database.getContext().fetch(Teams.fetchRequest()) as? [Teams] else { return nil}
        guard let team = teams.first else { return nil }
        return Team(team)
    }
    
    class func createTeam(team: Team) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        let teams = Teams(context: Database.getContext())
        teams.setTeam(team: team)
        let isSaved = Database.saveData()
        if isSaved {
            Logger.logSuccess(title: "Data Saved", description: "Team Saved to Core Data.")
        }
    }
    
    //MARK: ===============  Fixture Events Datababase Helpers =================
    class func getEvents(league: Leagues, endPoint: RequestEndpoints, fixtureId: String, completion: @escaping ([MatchEvent]?) -> ()) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            completion(nil)
            return
        }
        guard let id = Int64(fixtureId)
        else {
            Logger.log(title: "getEvents Error", description: "Error trying to Fetch Fixture Events for \(String(describing: league.name)), event id = \(fixtureId). Couldn't convert rawValue to Int64")
            completion(nil)
            return
        }
        guard let dataFetchRequest = NSFetchRequest<FixtureEvents>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
        else {
            Logger.log(title: "getEvents Error", description: "Error trying to Fetch FixtureEvents for \(String(describing: league.name)), event id = \(fixtureId). Couldn't convert NSFetchRequest<FixtureEvents> to NSFetchRequest<NSManagedObject>")
            completion(nil)
            return
        }
        dataFetchRequest.predicate = NSPredicate(format: "fixtureId == %i", id)
        guard let events = Database.fetchData(request: dataFetchRequest) as? [FixtureEvents]
        else {
            Logger.log(title: "getEvents Error", description: "Error trying to convert array of NSManagedObject to array of FixtureEvents")
            completion(nil)
            return
        }

        let fixtureEvents = events.map { (event) -> MatchEvent in
            return MatchEvent(event)
        }
        completion(fixtureEvents)
    }
    
    class func createEvent(fixtureId: String, event: MatchEvent) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        let events = FixtureEvents(context: Database.getContext())
        guard let id = Int64(fixtureId) else { return }
        events.setEvent(fixtureId: id, event: event)
        let isSaved = Database.saveData()
        if isSaved {
            Logger.logSuccess(title: "Data Saved", description: "Fixture Event Saved to Core Data.")
        }
    }
    
    //MARK: ===============  Fixture Stats Datababase Helpers =================
    class func createFixtureStats(fixtureId: String, matchStats: MatchStats) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return
        }
        let stats = FixtureStats(context: Database.getContext())
        guard let id = Int64(fixtureId) else { return }
        stats.setStat(fixtureId: id, matchStats: matchStats)
        let isSaved = Database.saveData()
        if isSaved {
            Logger.logSuccess(title: "Data Saved", description: "Fixture Stats Saved to Core Data.")
        }
    }
    
    class func getFixtureStats(league: Leagues, endPoint: RequestEndpoints, fixtureId: String, completion: @escaping (MatchStats?) -> ()) {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            completion(nil)
            return
        }
        guard let id = Int64(fixtureId)
        else {
            Logger.log(title: "getFixturesStats Error", description: "Error trying to Fetch Fixture Stats for \(String(describing: league.name)), event id = \(fixtureId). Couldn't convert rawValue to Int64")
            completion(nil)
            return
        }
        guard let dataFetchRequest = NSFetchRequest<FixtureStats>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
        else {
            Logger.log(title: "getFixturesStats Error", description: "Error trying to Fetch Fixture Stats for \(String(describing: league.name)), event id = \(fixtureId). Couldn't convert NSFetchRequest<FixtureStats> to NSFetchRequest<NSManagedObject>")
            completion(nil)
            return
        }
        dataFetchRequest.predicate = NSPredicate(format: "fixtureId == %i", id)
        guard let stats = Database.fetchData(request: dataFetchRequest) as? [FixtureStats]
        else {
            Logger.log(title: "getFixturesStats Error", description: "Error trying to convert array of NSManagedObject to array of FixtureStats")
            completion(nil)
            return
        }

        let fixtureStats = stats.map { (stats) -> MatchStats in
            return MatchStats(stats)
        }
        
        completion(fixtureStats.first)
    }
    
    class func delete(fromFixture id: String, endPoint: RequestEndpoints)  {
        if let requestType = RequestManager.instance.requestType,
           requestType == .mock {
            return 
        } else {
            guard let fixtureId = Int64(id) else {
                return
            }
            guard let requested = NSFetchRequest<FixtureStats>(entityName: endPoint.coreDataTable) as? NSFetchRequest<NSManagedObject>
            else {
                Logger.log(title: "deleteFixturesStats Error", description: "Error trying to delete all Fixture stats for \(String(describing: endPoint.forLeague?.rawValue)). Couldn't convert NSFetchRequest<Fixtures> to NSFetchRequest<NSManagedObject>")
                return
            }
            requested.predicate = NSPredicate(format: "fixtureId == %i", fixtureId)
            _ = Database.delete(request: requested)
        }
        
    }
}
