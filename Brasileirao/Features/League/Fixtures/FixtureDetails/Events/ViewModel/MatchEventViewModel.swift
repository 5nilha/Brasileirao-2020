//
//  MatchEventViewModel.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/14/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

enum EventType{
    case card(_ detail: String?)
    case goal
    case substitution
    case unknown
    
    init(rawValue: String, detail: String? = nil) {
        if rawValue == "Card" {
            self = .card(detail)
        } else if rawValue == "Goal" {
            self = .goal
        } else if rawValue == "subst" {
            self = .substitution
        } else {
            self = .unknown
        }
    }
    
    var key: String {
        switch self {
        case .card:
            return "Card"
        case .goal:
            return "Goal"
        case .substitution:
            return "subst"
        default:
            return ""
        }
    }
    
    var image: UIImage? {
        switch self {
        case .card(let detail):
            return detail == "Red Card" ? UIImage(named: "redCard") : UIImage(named: "yellowCard")
        case .goal:
            return UIImage(named: "bola")
        case .substitution:
            return UIImage(named: "substitution")
        default:
            return nil
        }
    }
}

struct MatchEventViewModel {
    var matchEvent: MatchEvent?
    
    init(matchEvent: MatchEvent) {
        self.matchEvent = matchEvent
    }
    
    var eventImage: UIImage? {
        return type.image
    }
    
    var elapsed: String {
        guard let elapsedTime = matchEvent?.elapsed else { return "" }
        return "\(elapsedTime)'"
    }
    
    var teamId: String {
        guard let id = matchEvent?.teamId else { return "" }
        return "\(id)"
    }
    
    var teamName: String {
        guard let name = matchEvent?.teamName else { return "" }
        return name
    }
    
    var playerId: String {
        guard let id = matchEvent?.playerId else { return "" }
        return "\(id)"
    }
    
    var playerName: String {
        guard let name = matchEvent?.playerName else { return "" }
        return name
    }
    
    var assistId: String {
        guard let id = matchEvent?.assistId else { return "" }
        return "\(id)"
    }
    
    var assistName: String {
        guard let assistName = matchEvent?.assistName else { return "" }
        return assistName
    }
    
    var type: EventType {
        guard let eventType = matchEvent?.type else { return .unknown }
        return EventType(rawValue: eventType, detail: matchEvent?.detail)
    }
    
    var detail: String {
        guard let eventDetail = matchEvent?.detail else { return "" }
        return eventDetail
    }
}
