//
//  BrasileiraoHttpCode.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/5/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

enum BrasileiraoHttpCode: Int, Equatable {
    
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case timeout = 408
    case serverError = 500
    case serviceUnavailable = 503
    case unknown = 999
}
