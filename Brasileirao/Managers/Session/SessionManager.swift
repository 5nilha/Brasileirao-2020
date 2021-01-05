//
//  SessionManager.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/6/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

class SessionManager {
    static let instance = SessionManager()
    private var sessionTask: URLSessionDataTask?
    
    func startSession(httpRequest: HttpRequest, completion: @escaping (Result<Data, RequestError>) -> ()) {
        if sessionTask != nil {
            cancelSession()
        }
        sessionTask = URLSession.shared.dataTask(with: httpRequest.request) { [weak self] (data, response, error) in
            if let requestError = error as? RequestError {
                Logger.log(error: requestError, info: "Error fetching API Data")
                DispatchQueue.main.async {
                    Utils.instance.showErrorAlert(title: requestError.title, body: requestError.description)
                }
                completion(.failure(RequestError.invalidURL))
                return
            }
            guard let response = response, let httpResponse = response as? HTTPURLResponse else {
                Logger.log(error: RequestError.unknown, info: "Response Invalid or nil")
                completion(.failure(RequestError.unknown))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode), let data = data else {
                let requestError = RequestError(httpStatusCode: httpResponse.statusCode)
                Logger.log(error: requestError, info: "\(httpResponse.statusCode) Error fetching API Data")
                DispatchQueue.main.async {
                    Utils.instance.showErrorAlert(title: requestError.title, body: requestError.description)
                }
                
                completion(.failure(requestError))
                return
            }
            
            Logger.debugServiceSuccess(info: "Data fetched from API", httpCode: BrasileiraoHttpCode.ok, response: response, data: data)
            DispatchQueue.main.async {
                completion(.success(data))
                self?.stopSession()
            }
        }
        resumeSession()
    }
    
    func resumeSession() {
        sessionTask?.resume()
    }
    
    func cancelSession() {
        sessionTask?.cancel()
    }
    
    func stopSession() {
        sessionTask?.suspend()
    }
    
}
