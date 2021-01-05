//
//  CampeonatoBrasileiroViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

struct CampeonatoBrasileiroViewModel {
    
    private let campeonatoBrasileiro: League
    
    init(campeonatoBrasileiro: League) {
        self.campeonatoBrasileiro = campeonatoBrasileiro
    }
    
    var id: String? {
        guard let leagueId = campeonatoBrasileiro.id else { return nil }
        return "\(leagueId)"
    }
    
    var name: String? {
        return campeonatoBrasileiro.name
    }
    
    var type: String? {
        return campeonatoBrasileiro.type
    }
    
    var season: String? {
        guard let season = campeonatoBrasileiro.edition else { return "" }
        return "\(season)"
    }
    
    var seasonStart: String? {
        return campeonatoBrasileiro.seasonStart
    }
    
    var seasonEnd: String? {
        return campeonatoBrasileiro.seasonEnd
    }
    
}
