//
//  RequestEndpointsTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao
class RequestEndpointsTest: XCTestCase {

    func testCampeonatoBrasileiroEndpoint() {
        XCTAssertEqual(RequestEndpoints.leagueInfo(.brazilian).url, "https://api-football-v1.p.rapidapi.com/")
        XCTAssertEqual(RequestEndpoints.leagueInfo(.brazilian).endPoint, "leagues/league/1396")
        XCTAssertEqual(RequestEndpoints.leagueInfo(.brazilian).completePath, "https://api-football-v1.p.rapidapi.com/leagues/league/1396")
        XCTAssertEqual(RequestEndpoints.leagueInfo(.brazilian).mockJson, "campeonato_brasileiro")
    }
}
