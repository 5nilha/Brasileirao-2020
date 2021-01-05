//
//  MockRequest.swift
//  BrasileiraoTests
//
//  Created by Fabio Quintanilha on 11/5/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

@testable import Brasileirao

final class MockRequest {
    
    var httpCode: BrasileiraoHttpCode?
    var error: NSError?
    var params: [String : Any]?
    var body: Data?
    var returnData: Data?
    var timesAttempted: Int?
    var fileForURL: ((_ url: String) -> String?)?
    
    required convenience init(returnData: Data? = nil, httpCode: BrasileiraoHttpCode? = .ok, fileForURL: @escaping ((_ url: String) -> String?)) {
        self.init()
        self.httpCode = httpCode
        self.fileForURL = fileForURL
        self.returnData = returnData
        self.timesAttempted = 0
    }
    
    
    /*
     * The following class function will mock a service call for Unit testing.
     * In the argument we pass the string for the API endpoint, the HTTP request Code we want to simulate the response and the json file which we have the Mock data.
     * The Mock Response can be used to test all possible responses and scenarios
    */
    @discardableResult class func mockBackendResponse(_ apiEndpoint: String, httpCode: BrasileiraoHttpCode, jsonFileName: String? = nil) -> MockRequest {
        
        let mock = MockRequest(httpCode: httpCode, fileForURL: { (url) -> String? in
            if url.containsIgnoringCase(apiEndpoint) {
                return jsonFileName
            }
            return nil
        })
        
        return mock
    }
    
    @discardableResult class func mockAPICall(_ apiEndpoint: String, httpCode: BrasileiraoHttpCode, jsonFileName: String? = nil) -> MockRequest {
        
        let mock = MockRequest(httpCode: httpCode, fileForURL: { (url) -> String? in
            if url.containsIgnoringCase(apiEndpoint) {
                return jsonFileName
            }
            return nil
        })
        
        return mock
    }
    
}
