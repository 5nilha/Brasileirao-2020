//
//  AwayTeamEventCell.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/15/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class AwayTeamEventCell: UITableViewCell {
    
    static let identifier = "awayTeamEventCell"

    @IBOutlet weak var eventMinute: UILabel?
    @IBOutlet weak var eventImage: UIImageView?
    @IBOutlet weak var mainEventName: UILabel?
    @IBOutlet weak var descriptionEventName: UILabel?
    
    func updateCell(event: MatchEventViewModel) {
        self.eventMinute?.text = event.elapsed
        self.mainEventName?.text = event.playerName
        self.descriptionEventName?.text = event.assistName
        self.eventImage?.image = event.eventImage
    }

}
