//
//  FixturesStatsProtocol.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

protocol FixturesStatsProtocol: Codable {
    var home: String? { get }
    var away: String? { get }
}
