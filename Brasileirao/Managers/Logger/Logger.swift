//
//  Logger.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/6/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

class Logger {
    
    class func logSuccess(title: String, description: String) {
        let errorTimestamp = Date().timeIntervalSince1970
        
        let log = [
            errorTimestamp: [
                "title" : title,
                "description" : description,
            ]]
        print(log)
    }
    
    class func log(title: String, description: String) {
        let errorTimestamp = Date().timeIntervalSince1970
        
        let errorLog = [
            errorTimestamp: [
                "title" : title,
                "description" : description,
                "errorDate" : errorTimestamp
            ]]
        
        print(errorLog)
    }
    
    class func log(error: RequestError?, info: String? = nil) {
        let errorDescription = error?.description
        let errorTitle = error?.title
        let errorTimestamp = Date().timeIntervalSince1970
        
        let errorLog = [
            errorTimestamp: [
                "title" : errorTitle ?? "",
                "description" : errorDescription ?? "",
                "errorDate" : errorTimestamp,
                "errorInfo" : info ?? ""
            ]]
        
        print(errorLog)
    }
    
    class func log(error: Error?, info: String? = nil) {
        let errorDescription = error?.localizedDescription
        let errorTimestamp = Date().timeIntervalSince1970
        
        let errorLog = [
            errorTimestamp: [
                "description" : errorDescription ?? "",
                "errorDate" : errorTimestamp,
                "errorInfo" : info ?? ""
            ]]
        
        print(errorLog)
    }
    
    class func debugServiceSuccess(info: String, httpCode: BrasileiraoHttpCode, response: URLResponse, data: Any) {
        print("========================= Debugging =============================")
        print("Information = \(info)")
        print("Response = \(response)")
        print("Data = \(data)")
        print("=================================================================")
    }
}
