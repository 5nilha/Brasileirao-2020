//
//  Utils.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class Utils {
    static var instance = Utils()
    
    weak var delegate: UtilsDelegates?
    private var internetChecker: InternetChecker?
    
    init() {
        startMonitoringNetwork()
    }
    
    func dissmissKeyboard() {
        delegate?.didEndEditing()
    }
    
    //MARK: ===================== GLobal Alert ============================
    
    func showErrorAlert(title: String?, body: String?) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok_action", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.delegate?.presentAlert(alertController)
    }
    
    
    //MARK: ===================== Device Monitor ============================
    func isDeviceOrientationPortrait() -> Bool {
        return UIDevice.current.orientation.isPortrait
    }
    
    private func startMonitoringNetwork() {
        internetChecker = InternetChecker()
        internetChecker?.startMonitoring()
    }
    
    func isDeviceOffline() -> Bool {
        guard let isConnected = internetChecker?.isConnected else { return false }
        return !isConnected
    }
    
    
    //MARK: ===================== Loading Spinner =============================
    func startLoading() {
        delegate?.didStartLoading()
    }
    
    func stopLoading() {
        delegate?.didEndLoading()
    }
}
