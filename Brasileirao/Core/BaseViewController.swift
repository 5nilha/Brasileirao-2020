//
//  BaseViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

/* Base View Controller should be used in all view controllers as a base controller. */

class BaseViewController: UIViewController {
    
    private lazy var spinnerController = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.instance.delegate = self
    }
}

extension BaseViewController: UtilsDelegates {
    func didEndEditing() {
        view.endEditing(true)
    }
    
    func didStartLoading() {
        self.addChild(spinnerController)
        self.spinnerController.view.frame = self.view.frame
        self.view.addSubview(spinnerController.view)
        self.spinnerController.didMove(toParent: self)
    }
    
    func didEndLoading() {
        self.spinnerController.stopSpinner()
        self.spinnerController.willMove(toParent: nil)
        self.spinnerController.view.removeFromSuperview()
        self.spinnerController.removeFromParent()
    }
    
    func presentAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true, completion: nil)
    }
}


