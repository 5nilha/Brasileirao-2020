//
//  CampeonatoBrasileiroMatchCell.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/11/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class CampeonatoBrasileiroMatchCell: UITableViewCell {
    
    static let identifier = "campeonatoBrasileiroMatchCell"

    @IBOutlet weak var homeTeamImage: UIImageView?
    @IBOutlet weak var homeTeamName: UILabel?
    @IBOutlet weak var homeTeamScore: UITextField?
    @IBOutlet weak var awayTeamImage: UIImageView?
    @IBOutlet weak var awayTeamScore: UITextField?
    @IBOutlet weak var awayTeamName: UILabel?
    @IBOutlet weak var gameDate: UILabel?
    @IBOutlet weak var gameTime: UILabel?
    private var matchViewModel: MatchViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func clearView() {
        homeTeamName?.text = ""
        homeTeamScore?.text = ""
        
        awayTeamName?.text = ""
        awayTeamScore?.text = ""

        gameDate?.text = ""
        gameTime?.text = ""
    }
    
    func updateCell(match: MatchViewModel) {
        self.matchViewModel = match
        homeTeamName?.text = match.homeTeam
        homeTeamScore?.text = match.scoreHomeTeam
        
        awayTeamName?.text = match.awayTeam
        awayTeamScore?.text = match.scoreAwayTeam

        gameDate?.text = match.formattedDate
        gameTime?.text = match.gameTime
        
        setImages(match: match)
    }
    
    private func setTextFieldStatus() {
        homeTeamScore?.isEnabled = homeTeamScore?.text == "" || homeTeamScore?.text == nil
        awayTeamScore?.isEnabled = awayTeamScore?.text == "" || awayTeamScore?.text == nil
    }
    
    @IBAction func didEndEditingScore(_ sender: UITextField) {
        Utils.instance.dissmissKeyboard()
        guard let homeScore = self.homeTeamScore?.text,
              let awayScore = awayTeamScore?.text,
                homeScore != "",
                awayScore != ""
        else {
            return
        }
        
        self.matchViewModel?.editScore(homeTeamScore: homeScore, awayTeamScore: awayScore)
    }
    
    private func setImages(match: MatchViewModel) {
        if let homeTeamImageURL = match.homeTeamLogoUrl {
            MainManager.shared.campeonatoBrasileiroHelper.downloadTeamImage(url: homeTeamImageURL, teamid: match.homeTeamId ?? "") { [weak self] (image) in
                self?.homeTeamImage?.image = image
            }
        }

        if let awayTeamImageURL = match.awayTeamLogoUrl {
            MainManager.shared.campeonatoBrasileiroHelper.downloadTeamImage(url: awayTeamImageURL, teamid: match.awayTeamId ?? "") { [weak self] (image) in
                self?.awayTeamImage?.image = image
            }
        }
    }
}
