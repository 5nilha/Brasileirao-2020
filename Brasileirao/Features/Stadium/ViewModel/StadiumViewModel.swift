//
//  StadiumViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

struct StadiumViewModel {
    private let stadium: Stadium?
    
    init(stadium: Stadium) {
        self.stadium = stadium
    }
    
    var name: String? {
        return stadium?.name
    }
    
}
