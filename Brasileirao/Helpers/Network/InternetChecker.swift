//
//  InternetChecker.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/17/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Network

final class InternetChecker {
    
    private var monitor: NWPathMonitor?
    public private (set) var isConnected: Bool?
    
    init() {
        monitor = NWPathMonitor()
        print("Monitoring internet")
    }
    
    private func checkConnectionStatus(status: NWPath.Status) {
        switch status {
        case .satisfied:
            isConnected = true
            print("We're connected!")
        default:
            isConnected = false
            print("No connection.")
        }
    }
    
    private func networkMonitor() {
        monitor?.pathUpdateHandler = { [weak self] path in
            self?.checkConnectionStatus(status: path.status)
            print(path.isExpensive)
        }
    }
    
    func startMonitoring() {
        let queue = DispatchQueue(label: "Monitor")
        monitor?.start(queue: queue)
        networkMonitor()
    }
}
