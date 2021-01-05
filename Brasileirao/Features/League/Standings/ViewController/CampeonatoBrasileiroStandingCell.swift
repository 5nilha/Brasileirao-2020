//
//  CampeonatoBrasileiroStandingCell.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/10/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class CampeonatoBrasileiroStandingCell: UITableViewCell {
    
    static let identifier = "campeonatoBrasileiroStandingCell"
    
    @IBOutlet weak var positionLabel: UILabel?
    @IBOutlet weak var teamLabel: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var gameLabel: UILabel?
    @IBOutlet weak var wonLabel: UILabel?
    @IBOutlet weak var drawLabel: UILabel?
    @IBOutlet weak var lossLabel: UILabel?
    @IBOutlet weak var teamImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(standingInfo: TeamStandingViewModel, index: Int) {
        self.positionLabel?.text = "\(index + 1)"
        self.teamLabel?.text = standingInfo.team
        self.pointsLabel?.text = standingInfo.points
        self.gameLabel?.text = standingInfo.matchesPlayed
        self.wonLabel?.text = standingInfo.won
        self.drawLabel?.text = standingInfo.draw
        self.lossLabel?.text = standingInfo.loss
        
        if let url = standingInfo.teamLogoURL {
            MainManager.shared.campeonatoBrasileiroHelper.downloadTeamImage(url: url, teamid: standingInfo.teamId) { [weak self] (image) in
                self?.teamImage?.image = image
            }
        }
    }
}
