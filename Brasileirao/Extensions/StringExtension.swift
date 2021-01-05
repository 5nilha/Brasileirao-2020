//
//  StringExtension.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/5/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

extension String {
    
    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: "", table: nil)
    }
    
    func containsIgnoringCase(_ find: String) -> Bool {
        return self.range(of: find, options: NSString.CompareOptions.caseInsensitive) != nil
    }
    
    var onlyNumbers: String {
        let number = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return number
    }
}
