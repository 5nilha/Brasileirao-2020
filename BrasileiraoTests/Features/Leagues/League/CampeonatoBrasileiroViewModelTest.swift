//
//  CampeonatoBrasileiroViewModelTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class CampeonatoBrasileiroViewModelTest: XCTestCase {

    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
        MainManager.shared.reset()
    }
    
    func testLeagueModel() {
        let campeonatoBrasileiroService = LeaguesService()
        campeonatoBrasileiroService.fetchLeagueData(.leagueInfo(.brazilian)) { (result) in
            switch result {
            case .success( let AllLeagues):
                guard let leagues = AllLeagues.leagues else {
                    XCTFail("league info is nil")
                    return
                }
                XCTAssertNotNil(leagues)
                XCTAssertEqual(leagues.count, 1)
                XCTAssertEqual(leagues[0].name, "Serie A")
                XCTAssertEqual(leagues[0].edition, 2020)
                XCTAssertEqual(leagues[0].id, 1396)
                XCTAssertEqual(leagues[0].flagURL, "https://media.api-sports.io/flags/br.svg")
                XCTAssertEqual(leagues[0].seasonStart, "2020-08-08")
                XCTAssertEqual(leagues[0].seasonEnd, "2021-02-24")
                XCTAssertEqual(leagues[0].type, "League")
            case .failure(_):
                XCTFail("league info is nil")
                return
            }
        }
    }

    func testCampeonatoBrasileiroViewModel() {
        MainManager.shared.campeonatoBrasileiroHelper.getCampeonatoBrasileiroInformation { (hasInfo) in
            guard let campeonatoBrasileiroViewModel = MainManager.shared.campeonatoBrasileiroHelper.campeonatoBrasileiroViewModel else {
                XCTFail("campeonatoBrasileiroViewModel is nil on helper")
                return
            }
            
            XCTAssertEqual(campeonatoBrasileiroViewModel.name, "Serie A")
            XCTAssertEqual(campeonatoBrasileiroViewModel.type, "League")
            XCTAssertEqual(campeonatoBrasileiroViewModel.season, "2020")
        }
        
    }

}
