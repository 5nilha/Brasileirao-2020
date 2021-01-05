//
//  CampeonatoBrasileiroMatchesViewController.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/11/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class CampeonatoBrasileiroMatchesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var matches = [[MatchViewModel]]()
    private var selectedMatch: MatchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        MainManager.shared.campeonatoBrasileiroHelper.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MainManager.shared.campeonatoBrasileiroHelper.getLeagueFixures { [weak self](hasFixtures) in
            if hasFixtures {
                self?.tableView?.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension CampeonatoBrasileiroMatchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count > section ? matches[section].count + 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if matches.count > indexPath.section {
            if indexPath.row == 0 {
                //Show Game Round Cell to show date details
                guard let cell = tableView.dequeueReusableCell(withIdentifier: GameRoundInfoCell.identifier, for: indexPath) as? GameRoundInfoCell
                else { return UITableViewCell() }
                let match = matches[indexPath.section][indexPath.row]
                cell.updateCell(match: match)
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CampeonatoBrasileiroMatchCell.identifier, for: indexPath) as? CampeonatoBrasileiroMatchCell
                else { return UITableViewCell() }
                let match = matches[indexPath.section][indexPath.row - 1]
                cell.updateCell(match: match)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            selectedMatch = matches[indexPath.section][indexPath.row - 1]
            performSegue(withIdentifier: MatchInfoViewController.identifier, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MatchInfoViewController.identifier {
            let destination = segue.destination as? MatchInfoViewController
            destination?.match = selectedMatch
        }
    }
}

extension CampeonatoBrasileiroMatchesViewController: CampeonatoBrasileiroDelegate{
    func didUpdate() {
        matches = MainManager.shared.campeonatoBrasileiroHelper.fixtures ?? [[MatchViewModel]]()
        tableView!.reloadData()
    }
}
