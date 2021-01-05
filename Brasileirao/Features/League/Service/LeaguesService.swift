//
//  LeaguesService.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

class LeaguesService {
    
    func fetchLeagueData(_ endpoint: RequestEndpoints, completion: @escaping (Result<AllLeagues, RequestError>) -> ()) {
        APIHandler.fetchAPIData(endpoint: endpoint) { (result) in
            switch result {
            case .success(let data):
                guard let allLeagues = LeagueParser.parser(data: data) else {
                    completion(.failure(RequestError.decodedError))
                    return
                }
                completion(.success(allLeagues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
