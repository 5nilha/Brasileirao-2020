//
//  LineupViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct LineupViewModel {
    
    private var lineup: Lineup?
    
    init(lineup: Lineup) {
        self.lineup = lineup
    }
    
    var coach: String? {
        return lineup?.coach
    }
    
    var formation: String? {
        return lineup?.formation
    }
    
    var startXI: [Player]? {
        return lineup?.startXI
    }
    
    var substitutes: [Player]? {
        return lineup?.substitutes
    }
}
