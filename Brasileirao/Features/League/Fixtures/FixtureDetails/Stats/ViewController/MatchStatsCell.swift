//
//  MatchStatsCell.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class MatchStatsCell: UITableViewCell {
    
    @IBOutlet weak var homeTeamData: UILabel?
    @IBOutlet weak var awayTeamData: UILabel?
    @IBOutlet weak var dataTitle: UILabel?
    
    static let identifier = "matchStatsCell"

    func updateCell(stats: (title: String, homeTeam: String, awaysTeam: String)) {
        self.homeTeamData?.text = stats.homeTeam
        self.awayTeamData?.text = stats.awaysTeam
        self.dataTitle?.text = stats.title
    }
}
