//
//  APIHandlerTest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import XCTest
@testable import Brasileirao

class APIHandlerTest: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        RequestManager.instance.mockRequest()
    }

    override class func tearDown() {
        super.tearDown()
        RequestManager.instance.reset()
    }

    func testFetchData() {
        
        APIHandler.fetchAPIData(endpoint: .leagueInfo(.brazilian)) { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail("Nil Data")
            }
        } 
    }
}
