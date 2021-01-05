//
//  CampeonatoBrasileiroHelper.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

protocol CampeonatoBrasileiroDelegate: AnyObject {
    func didUpdate()
}

final class CampeonatoBrasileiroHelper {
    
    public private (set) var campeonatoBrasileiroViewModel: CampeonatoBrasileiroViewModel?
    public private (set) var standingTable: [TeamStandingViewModel]?
    public private (set) var fixtures: [[MatchViewModel]]?
    public private (set) var fixturesStats: MatchStatsViewModel?
    public private (set) var fixtureEvents: [MatchEventViewModel]?
    lazy var leagueType = MainManager.shared.currentLeague
    typealias ImageHandler = (UIImage?) -> ()
    weak var delegate: CampeonatoBrasileiroDelegate?
    private var lastStandingUpdate: Date?
    private var lastFixturesUpdate: Date?
    private var lastFixtureStatsUpdate: Date?
    private var lastFixtureEventsUpdate: Date?
    typealias Handler = (Bool) -> ()
    
    func downloadTeamImage(url: URL, teamid: String, completion: ImageHandler?) {
        APIHandler.fetchImage(url, teamId: teamid) { (teamImage) in
            guard let handler = completion else { return }
            handler(teamImage)
        }
    }
    
    func getCampeonatoBrasileiroInformation(completion: Handler? = nil) {
        Utils.instance.startLoading()
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.leagueInfo(self.leagueType), completion: {  [weak self] (result) in
            guard let wself = self else { return }
            switch result {
            case .success(let allLeagues):
                guard let leagues = allLeagues.leagues,
                      leagues.count > 0,
                      let league = leagues.first else {
                    return
                }
                wself.campeonatoBrasileiroViewModel = CampeonatoBrasileiroViewModel(campeonatoBrasileiro: league)
                DispatchQueue.main.async {
                    guard let handler = completion else { return }
                    handler(true)
                    wself.delegate?.didUpdate()
                    Utils.instance.stopLoading()
                }
                
            case .failure(_):
                guard let handler = completion else { return }
                handler(false)
                Utils.instance.stopLoading()
            }
        })
    }
    
    //MARK: ===============  League Standing Helpers =================
    func getLeagueStandings(completion: Handler? = nil) {
        self.standingTable?.removeAll()
        Utils.instance.startLoading()
        
        //Always load the data from database first to show the user the View Populated
        DatabaseHelper.getStandings(endPoint: .leagueStandings(leagueType)) { [weak self] (standings) in
            guard let wself = self else {
                return
            }
            wself.standingTable = wself.setStandingViewModel(league: wself.leagueType, standings: standings, saveLocal: false)
            guard let handler = completion else { return }
            handler(true)
        }
        
        let lastUpdateDate = self.lastStandingUpdate ?? Date()
        if !(Utils.instance.isDeviceOffline()) &&
            ((lastUpdateDate <= Date.hoursAgo(hoursAgo: 6) ?? Date()) ||
            self.lastStandingUpdate == nil) {
            
            let campeonatoBrasileiroService = LeaguesService()
            let endpoint: RequestEndpoints = .leagueStandings(self.leagueType)
            campeonatoBrasileiroService.fetchLeagueData(endpoint, completion: {  [weak self] (result) in
                guard let wself = self else {
                    return
                    
                }

                switch result {
                case .success(let allLeagues):
                    guard let teamsStanding = allLeagues.standings,
                          teamsStanding.count > 0,
                          let leagueStandings = teamsStanding.first
                    else {
                        return
                    }
                    DatabaseHelper.deleteStanding(endPoint: .leagueStandings(wself.leagueType))
                    wself.standingTable = wself.setStandingViewModel(league: wself.leagueType, standings: leagueStandings, saveLocal: true)
                    wself.lastStandingUpdate = Date()
                    DispatchQueue.main.async {
                        wself.delegate?.didUpdate()
                        Utils.instance.stopLoading()
                    }
                case .failure(_):
                    guard let handler = completion else { return }
                    Utils.instance.stopLoading()
                    handler(false)
                }
            })
        } else {
            Utils.instance.stopLoading()
        }
    }
    
    func getImage(url: URL?, teamId: String) {
        guard let imageUrl = url else { return }
        self.downloadTeamImage(url: imageUrl, teamid: teamId, completion: nil)
    }
    
    func setStandingViewModel(league: Leagues, standings: [TeamStanding]?, saveLocal: Bool) -> [TeamStandingViewModel]? {
        guard let leagueStandings = standings else { return nil }
        var standingTable = leagueStandings.map({ [weak self] (teamStanding) -> TeamStandingViewModel in
            if saveLocal { DatabaseHelper.createStanding(league: league, teamStanding: teamStanding) }
            let teamStandingVM = TeamStandingViewModel(teamStanding: teamStanding)
            self?.getImage(url: teamStandingVM.teamLogoURL, teamId: teamStandingVM.teamId)
            return teamStandingVM
        })
        
        standingTable.sort { (teamStandingA, teamStandingB) -> Bool in
            return teamStandingA.points > teamStandingB.points
        }
        return standingTable
    }
    
    //MARK: ===============  League Fixtures Helpers =================
    typealias fixturesHandler = (Bool) -> ()
    func getLeagueFixures(completion: Handler? = nil) {
        self.fixtures?.removeAll()
        Utils.instance.startLoading()

        //Always load the data from database first to show the user the View Populated
        DatabaseHelper.getFixtures(endPoint: .fixtures(self.leagueType)) { [weak self] (matches) in
            guard let fixtures = matches else {
                guard let handler = completion else { return }
                handler(false)
                return
            }
            self?.fixtures = self?.setFixtureViewModel(fixtures: fixtures, saveLocal: false)
            guard let handler = completion else { return }
            handler(true)
        }
        
        let lastUpdateDate = self.lastFixturesUpdate ?? Date()
        if !(Utils.instance.isDeviceOffline()) &&
            ((lastUpdateDate <= Date.hoursAgo(hoursAgo: 6) ?? Date()) || self.lastFixturesUpdate == nil) {
            
            let campeonatoBrasileiroService = LeaguesService()
            campeonatoBrasileiroService.fetchLeagueData(.fixtures(self.leagueType), completion: {  [weak self] (result) in
                guard let wself = self else { return }
                switch result {
                case .success(let allLeagues):
                    DatabaseHelper.deleteFixtures(endPoint: .fixtures(wself.leagueType))
                    wself.fixtures = self?.setFixtureViewModel(fixtures: allLeagues.fixtures, saveLocal: true)
                    wself.lastFixturesUpdate = Date()
                    DispatchQueue.main.async {
                        wself.delegate?.didUpdate()
                        Utils.instance.stopLoading()
                    }
                case .failure(_):
                    guard let handler = completion else { return }
                    Utils.instance.stopLoading()
                    handler(false)
                }
            })
        } else {
            Utils.instance.stopLoading()
        }
    }
    
    private func setFixtureViewModel(fixtures allFixtures: [Match]?,  saveLocal: Bool) -> [[MatchViewModel]]? {
        var leagueMatchesDic = [Int : [MatchViewModel]]()
        guard let fixturesList = allFixtures else { return nil }
        
        for fixture in fixturesList {
            if saveLocal {DatabaseHelper.createFixture(fixture: fixture)}
            let match = MatchViewModel(match: fixture)
            guard let round = match.round else { continue }
            if leagueMatchesDic[round] != nil {
                leagueMatchesDic[round]?.append(match)
            } else {
                leagueMatchesDic[round] = [match]
            }
        }
        var fixtures = leagueMatchesDic.compactMap({ (_, roundFixturesList) -> [MatchViewModel] in
            return roundFixturesList.sorted { (fixtureA, fixtureB) -> Bool in
                guard let fixtureADate = fixtureA.date, let fixtureBDate = fixtureB.date else { return true }
                return fixtureADate < fixtureBDate
            }
        })
        fixtures.sort(by: { (fixtureRoundA, fixtureRoundB) -> Bool in
            guard let matchARound = fixtureRoundA.first?.round, let matchBRound = fixtureRoundB.first?.round else { return true }
            return matchARound < matchBRound
        })
        return fixtures
    }
    
    //MARK: ===============  League Fixtures Stats Helpers =================
    func getFixturesStats(fixtureId: String, completion: Handler? = nil) {
        Utils.instance.startLoading()
        DatabaseHelper.getFixtureStats(league: .brazilian, endPoint: .fixturesStatistics(fixtureId), fixtureId: fixtureId, completion: { (matchStats) in
            self.fixturesStats = self.setFixtureStatsViewModel(fixtureId: fixtureId, matchStats: matchStats, saveLocal: false)
            guard let handler = completion else { return }
            handler(true)
        })
        
        let lastUpdateDate = self.lastFixtureStatsUpdate ?? Date()
        if !(Utils.instance.isDeviceOffline()) &&
            ((lastUpdateDate <= Date.hoursAgo(hoursAgo: 6) ?? Date()) || self.lastFixtureStatsUpdate == nil) {
            
            let campeonatoBrasileiroService = LeaguesService()
            campeonatoBrasileiroService.fetchLeagueData(.fixturesStatistics(fixtureId), completion: {  [weak self] (result) in
                switch result {
                case .success(let allLeagues):
                    guard let matchStats = allLeagues.fixturesStats else {
                        return
                    }
                    DatabaseHelper.delete(fromFixture: fixtureId, endPoint: .fixturesStatistics(fixtureId))
                    self?.fixturesStats = self?.setFixtureStatsViewModel(fixtureId: fixtureId, matchStats: matchStats, saveLocal: true)
                    self?.lastFixtureStatsUpdate = Date()
                    DispatchQueue.main.async {
                        self?.delegate?.didUpdate()
                        Utils.instance.stopLoading()
                    }
                case .failure(_):
                    guard let handler = completion else { return }
                    handler(false)
                    Utils.instance.stopLoading()
                }
            })
        } else {
            Utils.instance.stopLoading()
        }
    }
    
    func setFixtureStatsViewModel(fixtureId: String, matchStats: MatchStats?, saveLocal: Bool) -> MatchStatsViewModel? {
        guard let stats = matchStats else {
            return nil
        }
        
        if saveLocal { DatabaseHelper.createFixtureStats(fixtureId: fixtureId, matchStats: stats) }
        let fixturesStatsVM = MatchStatsViewModel(matchStats: stats)
        return fixturesStatsVM
    }
    
    
    //MARK: ===============  League Fixtures Events Helpers =================
    func getFixtureEvents(fixtureId: String, completion: Handler?  = nil) {
        self.fixtureEvents?.removeAll()
        Utils.instance.startLoading()
        DatabaseHelper.getEvents(league: .brazilian, endPoint: .fixtureEvents(fixtureId), fixtureId: fixtureId) { (matchEvents) in
            self.fixtureEvents = self.setFixtureEventsViewModel(fixtureId: fixtureId, matchEvents: matchEvents, saveLocal: false)
            guard let handler = completion else { return }
            handler(true)
        }

        let lastUpdateDate = self.lastFixtureEventsUpdate ?? Date()
        if !(Utils.instance.isDeviceOffline()) &&
            ((lastUpdateDate <= Date.hoursAgo(hoursAgo: 6) ?? Date()) || self.lastFixtureEventsUpdate == nil) {
            let campeonatoBrasileiroService = LeaguesService()
            campeonatoBrasileiroService.fetchLeagueData(.fixtureEvents(fixtureId), completion: {  [weak self] (result) in
                guard let wself = self else {
                    return
                }
                switch result {
                case .success(let allLeagues):
                    DatabaseHelper.delete(fromFixture: fixtureId, endPoint: .fixtureEvents(fixtureId))
                    self?.fixtureEvents = wself.setFixtureEventsViewModel(fixtureId: fixtureId, matchEvents: allLeagues.fixturesEvents, saveLocal: true)
                    self?.lastFixtureEventsUpdate = Date()
                    DispatchQueue.main.async {
                        self?.delegate?.didUpdate()
                        Utils.instance.stopLoading()
                    }
                case .failure(_):
                    guard let handler = completion else { return }
                    Utils.instance.stopLoading()
                    handler(false)
                }
            })
        } else {
            Utils.instance.stopLoading()
        }
    }
    
    func setFixtureEventsViewModel(fixtureId: String, matchEvents: [MatchEvent]?, saveLocal: Bool) -> [MatchEventViewModel]? {
        guard let events = matchEvents else { return nil }
        let fixtureEventsVM = events.map({ (event) -> MatchEventViewModel in
            if saveLocal { DatabaseHelper.createEvent(fixtureId: fixtureId, event: event) }
            return MatchEventViewModel(matchEvent: event)
        })
        return fixtureEventsVM
    } 
}
