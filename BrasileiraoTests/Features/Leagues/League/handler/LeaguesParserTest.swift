//
//  CampeonatoParserTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class LeaguesParserTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }

    func testLeagueParser() {
        APIHandler.fetchAPIData(endpoint: .leagueInfo(.brazilian)) { (result) in
            switch result {
            case .success(let data):
                guard let campeonatoBrasileiro = LeagueParser.parser(data: data) else {
                    XCTFail("Error Parsing Data")
                    return
                }
                XCTAssertNotNil(campeonatoBrasileiro)
                XCTAssertEqual(campeonatoBrasileiro.results, 1)
                XCTAssertEqual(campeonatoBrasileiro.leagues?.count, 1)
                XCTAssertEqual(campeonatoBrasileiro.leagues?.first?.name, "Serie A")
            case .failure(_):
                XCTFail("Nil Data")
            }
        }
    }

}
