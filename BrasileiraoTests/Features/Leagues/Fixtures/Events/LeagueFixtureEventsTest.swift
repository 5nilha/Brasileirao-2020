//
//  LeagueFixtureEventsTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/14/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class LeagueFixtureEventsTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }
    
    func testLeagueEventsModel() {
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.fixtureEvents("327992")) { (result) in
            switch result {
            case .success( let AllLeagues):
                guard let events = AllLeagues.fixturesEvents else {
                    XCTFail("fixtureEvents is nil")
                    return
                }
                XCTAssertNotNil(events)
                XCTAssertEqual(events.count, 17)
                XCTAssertEqual(events[0].teamName, "Internacional")
                XCTAssertEqual(events[0].teamId, 119)
                XCTAssertEqual(events[0].playerId, 2470)
                XCTAssertEqual(events[0].playerName, "Renzo Saravia")
                XCTAssertEqual(events[0].assistId, nil)
                XCTAssertEqual(events[0].assistName, nil)
                XCTAssertEqual(events[0].type, "Card")
                XCTAssertEqual(events[0].detail, "Yellow Card")
            case .failure(_):
                XCTFail("fixtureEvents is nil")
                return
            }
        }
    }

    func testLeagueEventsViewModel() {
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.fixtureEvents("327992")) { (result) in
            switch result {
            case .success( let AllLeagues):
                guard let events = AllLeagues.fixturesEvents,
                      let firstEvent = events.first
                      else {
                    XCTFail("fixtureEvents is nil")
                    return
                }
                
                let event = MatchEventViewModel(matchEvent: firstEvent)
       
                XCTAssertEqual(event.teamId, "119")
                XCTAssertEqual(event.teamName, "Internacional")
                XCTAssertEqual(event.playerId, "2470")
                XCTAssertEqual(event.playerName, "Renzo Saravia")
                XCTAssertEqual(event.assistId, "0")
                XCTAssertEqual(event.assistName, "")
                XCTAssertEqual(event.detail, "Yellow Card")
            case .failure(_):
                XCTFail("fixtureEvents is nil")
                return
            }
        }
    }
}
