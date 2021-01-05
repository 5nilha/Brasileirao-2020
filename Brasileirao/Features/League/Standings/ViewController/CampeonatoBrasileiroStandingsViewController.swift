//
//  CampeonatoBrasileiroStandingsViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/12/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.


import UIKit

class CampeonatoBrasileiroStandingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView?
    let utils = Utils.instance
    private var standings: [TeamStandingViewModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        MainManager.shared.campeonatoBrasileiroHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MainManager.shared.campeonatoBrasileiroHelper.getLeagueStandings { [weak self] (hasStandings) in
            if hasStandings {
                self?.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension CampeonatoBrasileiroStandingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let teamStanding = standings,
           let cell = tableView.dequeueReusableCell(withIdentifier: CampeonatoBrasileiroStandingCell.identifier, for: indexPath) as? CampeonatoBrasileiroStandingCell {
            cell.updateCell(standingInfo: teamStanding[indexPath.row], index: indexPath.row)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension CampeonatoBrasileiroStandingsViewController: CampeonatoBrasileiroDelegate{
    func didUpdate() {
        standings = MainManager.shared.campeonatoBrasileiroHelper.standingTable
        tableView?.reloadData()
    }
}
