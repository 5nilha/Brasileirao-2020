//
//  LeagueFixturesTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/18/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class LeagueFixturesTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }

    func testLeagueFixtures() {
        MainManager.shared.campeonatoBrasileiroHelper.getLeagueFixures()
        guard let fixture = MainManager.shared.campeonatoBrasileiroHelper.fixtures else {
            XCTFail("fixture is nil on helper")
            return
        }
        XCTAssertNotNil(fixture)
        let firstRound = fixture.first
        let firstGame = firstRound?.first
        
        XCTAssertEqual(firstGame?.id, "327992")
        XCTAssertEqual(firstGame?.leagueId, "1396")
        XCTAssertEqual(firstGame?.round, 1)
        XCTAssertEqual(firstGame?.homeTeam, "Coritiba")
        XCTAssertEqual(firstGame?.homeTeamId, "147")
        XCTAssertEqual(firstGame?.awayTeam, "Internacional")
        XCTAssertEqual(firstGame?.awayTeamId, "119")
        XCTAssertEqual(firstGame?.homeTeamLogoUrl?.absoluteString, "https://media.api-sports.io/football/teams/147.png")
        XCTAssertEqual(firstGame?.awayTeamLogoUrl?.absoluteString, "https://media.api-sports.io/football/teams/119.png")
        XCTAssertEqual(firstGame?.scoreHomeTeam, "0")
        XCTAssertEqual(firstGame?.scoreAwayTeam, "1")
        XCTAssertEqual(firstGame?.status, "Match Finished")
        XCTAssertEqual(firstGame?.gameDate, "2020-08-08T22:30:00+00:00")
        XCTAssertEqual(firstGame?.formattedDate, "08 De Agosto")
        XCTAssertEqual(firstGame?.date,Date(timeIntervalSince1970: Double (1596925800)))
        XCTAssertEqual(firstGame?.formattedDate, "08 De Agosto")
    }

}
