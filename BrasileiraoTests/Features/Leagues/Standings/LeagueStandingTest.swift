//
//  LeagueStandingTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/19/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class LeagueStandingTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }
    
    func testLeagueStandinModel() {
        
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.leagueStandings(.brazilian)) { (result) in
            switch result {
            case .success(let allLeagues):
                guard let standing = allLeagues.standings?.first else {
                    XCTFail("fixtureEvents is nil")
                    return
                }
                XCTAssertNotNil(standing)
                XCTAssertEqual(standing.count, 20)
                
                guard let firstPlace = standing.first else {
                    XCTFail("Failed getting first TeamStanding")
                    return
                }
                
                XCTAssertEqual(firstPlace.position, 1)
                XCTAssertEqual(firstPlace.id, 119)
                XCTAssertEqual(firstPlace.teamName, "Internacional")
                XCTAssertEqual(firstPlace.teamLogo, "https://media.api-sports.io/football/teams/119.png")
                
            case .failure(_):
                XCTFail("Failed getting first TeamStanding")
                return
            }
            
            
        }
    }

    func testLeagueStandingViewModel() {
        
        MainManager.shared.campeonatoBrasileiroHelper.getLeagueStandings { (hasStandings) in
            guard let standings = MainManager.shared.campeonatoBrasileiroHelper.standingTable else {
                XCTFail("fixtureEvents is nil on helper")
                return
            }
            
            XCTAssertNotNil(standings)
            XCTAssertEqual(standings.count, 20)
            
            guard let firstPlace = standings.first else {
                XCTFail("Failed getting first TeamStanding")
                return
            }
            
            XCTAssertEqual(firstPlace.position, "1")
            XCTAssertEqual(firstPlace.teamId, "119")
            XCTAssertEqual(firstPlace.team, "Internacional")
            XCTAssertEqual(firstPlace.teamLogoURL?.absoluteString, "https://media.api-sports.io/football/teams/119.png")
            XCTAssertEqual(firstPlace.matchesPlayed, "10")
            XCTAssertEqual(firstPlace.lastGames, ["D", "L", "D", "W" ,"W"])
            XCTAssertEqual(firstPlace.won, "4")
            XCTAssertEqual(firstPlace.loss, "4")
            XCTAssertEqual(firstPlace.draw, "2")
            XCTAssertEqual(firstPlace.goalsFor, "13")
            XCTAssertEqual(firstPlace.goalsAgainst, "10")
            XCTAssertEqual(firstPlace.goalsDifference, "12")
        }
    }
    
    func testUpdateStanding() {
        RequestManager.instance.mockRequest()
        MainManager.shared.campeonatoBrasileiroHelper.getLeagueStandings { (hasStandings) in
            guard let standings = MainManager.shared.campeonatoBrasileiroHelper.standingTable else {
                XCTFail("fixtureEvents is nil on helper")
                return
            }
            
            XCTAssertNotNil(standings)
            XCTAssertEqual(standings.count, 20)
            
            guard let firstPlace = standings.first else {
                XCTFail("Failed getting first TeamStanding")
                return
            }
            let isUpdated = firstPlace.updateStanding(goalsFor: 4, goalsAgainst: 1, for: .brazilian)
            XCTAssertTrue(isUpdated)
            
            XCTAssertEqual(firstPlace.position, "119")
            XCTAssertEqual(firstPlace.team, "Internacional")
            XCTAssertEqual(firstPlace.teamLogoURL?.absoluteString, "https://media.api-sports.io/football/teams/119.png")
            XCTAssertEqual(firstPlace.matchesPlayed, "11")
            XCTAssertEqual(firstPlace.lastGames, ["D", "L", "D", "W" ,"W"])
            XCTAssertEqual(firstPlace.won, "5")
            XCTAssertEqual(firstPlace.loss, "4")
            XCTAssertEqual(firstPlace.draw, "2")
            XCTAssertEqual(firstPlace.goalsFor, "17")
            XCTAssertEqual(firstPlace.goalsAgainst, "10")
            XCTAssertEqual(firstPlace.goalsDifference, "16")
            RequestManager.instance.reset()
            MainManager.shared.reset()
        }
    }

}
