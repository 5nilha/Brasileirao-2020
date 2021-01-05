//
//  Leagues.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/16/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

enum Leagues: String {
    case brazilian = "1396"
    
    var name: String {
        switch self {
        case .brazilian:
            return "Brazilian League"
        }
    }
}
