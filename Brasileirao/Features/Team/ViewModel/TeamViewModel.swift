//
//  TeamViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct TeamViewModel: Decodable {
    
    public var team: Team?
    
    init(team: Team?) {
        self.team = team
    }
    
    var id: String? {
        guard let id = team?.id else { return nil}
        return "\(id)"
    }
    
    var name: String? {
        return team?.name
    }
    
    var logoURL: URL? {
        guard let urlString = team?.logoURL, let url = URL(string: urlString) else { return nil }
        return url
    }
}
