//
//  HttpRequestTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class HttpRequestTest: XCTestCase {

    func testHttpRequestForCampeonatoBrasileiro() {
        guard let url =  URL(string: "https://api-football-v1.p.rapidapi.com/leagues/league/1396") else {
            XCTFail("URL error")
            return
        }
        let httpRequest = HttpRequest(url: url, endpoint: .leagueInfo(.brazilian))
        XCTAssertNotNil(httpRequest.url)
        XCTAssertNotNil(httpRequest.endpoint)
        XCTAssertEqual(httpRequest.request.url, url)
    }

}
