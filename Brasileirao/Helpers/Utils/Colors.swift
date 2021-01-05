//
//  Colors.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/17/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

enum Colors {
    case primary(_ alpha: CGFloat)
    case secondary(_ alpha: CGFloat)
    
    
    var name: String {
        switch self {
        case .primary:
            return "primaryColor"
        case .secondary:
            return "secondaryColor"
        }
    }
    
    var uiColor: UIColor? {
        switch self {
        case .primary(let alpha), .secondary(let alpha):
            return UIColor(named: self.name)?.withAlphaComponent(alpha)
        }
    }
}
