//
//  MatchDetailViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/11/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    static let identifier = "matchDetailViewControllerSegue"

    @IBOutlet weak var statdiumName: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var match: MatchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateView()
    }
    
    func updateView() {
        statdiumName?.text = match?.stadiumName
        
        homeTeamName?.text = match?.homeTeam?.name
        awayTeamName?.text = match?.awayTeam?.name
        homeTeamScore?.text = match?.scoreHomeTeam
        awayTeamScore?.text = match?.scoreAwayTeam
        
        statusLabel?.text = match?.status
        
        if let homeTeamImageURL = match?.homeTeam?.escudoUrl {
            homeTeamImage?.sd_setImage(with: homeTeamImageURL)
        }
        if let awayTeamImageURL = match?.awayTeam?.escudoUrl {
            awayTeamImage?.sd_setImage(with: awayTeamImageURL)
        }
        
    }
    

}
