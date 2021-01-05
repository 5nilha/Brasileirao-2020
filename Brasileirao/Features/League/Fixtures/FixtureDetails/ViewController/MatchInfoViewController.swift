//
//  MatchInfoViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/13/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class MatchInfoViewController: BaseViewController {
    
    @IBOutlet weak var homeTeamImage: UIImageView?
    @IBOutlet weak var awayTeamImage: UIImageView?
    
    @IBOutlet weak var homeTeamName: UILabel?
    @IBOutlet weak var awayTeamName: UILabel?
    
    @IBOutlet weak var homeTeamScore: UILabel?
    @IBOutlet weak var awayTeamScore: UILabel?
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    static let identifier = "matchDetailViewControllerSegue"
    private var matchStatsViewModel: MatchStatsViewModel?
    private var matchEventsViewModel: [MatchEventViewModel]?
    internal var match: MatchViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        MainManager.shared.campeonatoBrasileiroHelper.delegate = self
        segmentedControl.selectedSegmentIndex = 0
        loadMatchEvents()
        updateTopView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MainManager.shared.campeonatoBrasileiroHelper.delegate = nil
    }
    
    func loadMatchEvents() {
        if let fixtureId = self.match?.id {
            MainManager.shared.campeonatoBrasileiroHelper.getFixtureEvents(fixtureId: fixtureId) { [weak self] (hasEvents) in
                if hasEvents {
                    self?.updateView()
                }
            }
        }
    }
    
    func loadMatchStats() {
        if let fixtureId = self.match?.id {
            MainManager.shared.campeonatoBrasileiroHelper.getFixturesStats(fixtureId: fixtureId) { [weak self] (hasStats) in
                if hasStats {
                    self?.updateView()
                }
            }
        }
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 && self.matchStatsViewModel == nil {
            loadMatchStats()
        }
        updateView()
    }
    
    func updateTopView() {
        homeTeamName?.text = match?.homeTeam
        awayTeamName?.text = match?.awayTeam
        homeTeamScore?.text = match?.scoreHomeTeam
        awayTeamScore?.text = match?.scoreAwayTeam
        
        if let homeTeamImageURL = match?.homeTeamLogoUrl {
            MainManager.shared.campeonatoBrasileiroHelper.downloadTeamImage(url: homeTeamImageURL, teamid: match?.homeTeamId ?? "") { [weak self] (image) in
                self?.homeTeamImage?.image = image
            }
        }
        if let awayTeamImageURL = match?.awayTeamLogoUrl {
            MainManager.shared.campeonatoBrasileiroHelper.downloadTeamImage(url: awayTeamImageURL, teamid: match?.awayTeamId ?? "") { [weak self] (image) in
                self?.awayTeamImage?.image = image
            }
        }
    }
    
    func updateView() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.matchEventsViewModel = MainManager.shared.campeonatoBrasileiroHelper.fixtureEvents
        case 1:
            self.matchStatsViewModel = MainManager.shared.campeonatoBrasileiroHelper.fixturesStats
        default:
            break
        }
        self.tableView?.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MatchInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let events = matchEventsViewModel else { return 0 }
            return events.count
            
        } else {
            guard let stats = matchStatsViewModel?.stats else { return 0 }
            return stats.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let events = matchEventsViewModel else { return UITableViewCell() }
            let event = events[indexPath.row]
            if event.teamId == self.match?.homeTeamId {
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeTeamEventCell.identifier, for: indexPath) as? HomeTeamEventCell
                cell?.updateCell(event: event)
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AwayTeamEventCell.identifier, for: indexPath) as? AwayTeamEventCell
                cell?.updateCell(event: event)
                return cell ?? UITableViewCell()
            }
        } else {
            guard let stats = matchStatsViewModel?.stats,
                  let cell = tableView.dequeueReusableCell(withIdentifier: MatchStatsCell.identifier, for: indexPath) as? MatchStatsCell
            else {
                return UITableViewCell()
            }
            cell.updateCell(stats: stats[indexPath.row])
            return cell
        }
    }
}

extension MatchInfoViewController: CampeonatoBrasileiroDelegate {
    func didUpdate() {
        updateView()
    }
}
