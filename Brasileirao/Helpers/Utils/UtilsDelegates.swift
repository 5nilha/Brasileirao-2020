//
//  UtilsDelegates.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

protocol UtilsDelegates: AnyObject {
    func presentAlert(_ alertController: UIAlertController)
    func didStartLoading()
    func didEndLoading()
    func didEndEditing()
}
