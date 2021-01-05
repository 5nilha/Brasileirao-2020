//
//  SpinnerViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/17/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)
    
    var loadingLabel: UILabel = {
        let loadingLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = "loading".localized
        loadingLabel.font = UIFont(name: "system", size: 17)
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        return loadingLabel
    }()
    
    var vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = Colors.secondary(0.6).uiColor
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(spinner)
        vStack.addArrangedSubview(loadingLabel)
        spinner.color = .white
        self.setSpinnerConstraints()
        self.startSpinner()
    }

    func setSpinnerConstraints() {
        loadingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        vStack.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 0).isActive = true
        vStack.trailingAnchor.constraint(equalToSystemSpacingAfter: self.view.trailingAnchor, multiplier: 0).isActive = true
        vStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
    }
    
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.startAnimating()
    }
}
