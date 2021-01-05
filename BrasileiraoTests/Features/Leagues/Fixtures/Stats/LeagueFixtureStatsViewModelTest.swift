//
//  LeagueFixtureStatsViewModelTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class LeagueFixtureStatsViewModelTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }
    
    func testLeagueFixtureStatsModel() {
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.fixturesStatistics("327992")) { (result) in
            switch result {
            case .success( let AllLeagues):
                guard let stats = AllLeagues.fixturesStats else {
                    XCTFail("fixtureStats is nil")
                    return
                }
                XCTAssertNotNil(stats)
                
                XCTAssertEqual(stats.shotsOnGoal?.home, "0")
                XCTAssertEqual(stats.shotsOnGoal?.away, "4")
                
                XCTAssertEqual(stats.totalShots?.home, "1")
                XCTAssertEqual(stats.totalShots?.away, "8")
                
                XCTAssertEqual(stats.fouls?.home, "5")
                XCTAssertEqual(stats.fouls?.away, "13")
                
                XCTAssertEqual(stats.offsides?.home, "3")
                XCTAssertEqual(stats.offsides?.away, "2")
                
                XCTAssertEqual(stats.corners?.home, "2")
                XCTAssertEqual(stats.corners?.away, "6")
                
                XCTAssertEqual(stats.yellowCards?.home, "3")
                XCTAssertEqual(stats.yellowCards?.away, "4")
                
                XCTAssertEqual(stats.redCards?.home, "0")
                XCTAssertEqual(stats.redCards?.away, "0")
                
                XCTAssertEqual(stats.ballPossession?.home, "35%")
                XCTAssertEqual(stats.ballPossession?.away, "65%")
                
                XCTAssertEqual(stats.totalPasses?.home, "189%")
                XCTAssertEqual(stats.totalPasses?.away, "329")
            case .failure(_):
                XCTFail("fixtureStats is nil")
                return
            }
        }
    }

    func testLeagueFixtureStatsViewModel() {
        
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.fixturesStatistics("327992")) { (result) in
            switch result {
            case .success( let AllLeagues):
                guard let stats = AllLeagues.fixturesStats else {
                    XCTFail("fixtureStats is nil")
                    return
                }
                
                
                let fixtureStats = MatchStatsViewModel(matchStats: stats)
                
                XCTAssertEqual(fixtureStats.stats.first?.title, "shot_to_goal".localized)
                XCTAssertEqual(fixtureStats.stats.first?.homeTeam, "0")
                XCTAssertEqual(fixtureStats.stats.first?.awaysTeam, "4")
                
                XCTAssertEqual(fixtureStats.stats[1].title, "total_shots".localized)
                XCTAssertEqual(fixtureStats.stats[1].homeTeam, "1")
                XCTAssertEqual(fixtureStats.stats[1].awaysTeam, "8")
                
                XCTAssertEqual(fixtureStats.stats[2].title, "fouls".localized)
                XCTAssertEqual(fixtureStats.stats[2].homeTeam, "5")
                XCTAssertEqual(fixtureStats.stats[2].awaysTeam, "13")
                
                XCTAssertEqual(fixtureStats.stats[3].title, "offsides".localized)
                XCTAssertEqual(fixtureStats.stats[3].homeTeam, "3")
                XCTAssertEqual(fixtureStats.stats[3].awaysTeam, "2")
                
                XCTAssertEqual(fixtureStats.stats[4].title, "corners".localized)
                XCTAssertEqual(fixtureStats.stats[4].homeTeam, "2")
                XCTAssertEqual(fixtureStats.stats[4].awaysTeam, "6")
                
                XCTAssertEqual(fixtureStats.stats[5].title, "ball_possession".localized)
                XCTAssertEqual(fixtureStats.stats[5].homeTeam, "35%")
                XCTAssertEqual(fixtureStats.stats[5].awaysTeam, "65%")
                
                XCTAssertEqual(fixtureStats.stats[6].title, "yellow_cards".localized)
                XCTAssertEqual(fixtureStats.stats[6].homeTeam, "3")
                XCTAssertEqual(fixtureStats.stats[6].awaysTeam, "4")
                
                XCTAssertEqual(fixtureStats.stats[7].title, "red_cards".localized)
                XCTAssertEqual(fixtureStats.stats[7].homeTeam, "0")
                XCTAssertEqual(fixtureStats.stats[7].awaysTeam, "0")
                
                XCTAssertEqual(fixtureStats.stats[8].title, "total_passes".localized)
                XCTAssertEqual(fixtureStats.stats[8].homeTeam, "189")
                XCTAssertEqual(fixtureStats.stats[8].awaysTeam, "329")
            case .failure(_):
                XCTFail("fixtureStats is nil")
                return
            }
        }
        
        
    }
}
