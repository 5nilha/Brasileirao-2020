//
//  MainManager.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/9/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

protocol ControllerObserver: AnyObject {
    func didNotify()
}

final class MainManager {
    
    static private (set) var shared = MainManager()
    lazy var campeonatoBrasileiroHelper = CampeonatoBrasileiroHelper()
    public private (set) var currentLeague: Leagues = .brazilian
    
    weak public private (set) var observer: ControllerObserver?
    
    init(){}
    
    func startObserver(on observer: ControllerObserver) {
        self.observer = observer
    }
    
    func removeObserver() {
        self.observer = nil
    }
    
    func reset() {
        campeonatoBrasileiroHelper = CampeonatoBrasileiroHelper()
        observer = nil
    }
    
    func setLeague(league: Leagues) {
        self.currentLeague = league
    }

}

