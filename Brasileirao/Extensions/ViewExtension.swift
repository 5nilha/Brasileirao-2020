//
//  ViewExtension.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/10/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

extension UIView {
    
    var cicle: Void {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
}
