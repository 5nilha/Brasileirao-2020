//
//  RequestManager.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/8/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import UIKit

enum RequestTypes {
    case mock
}

class RequestManager {
    static public private (set) var instance = RequestManager()
    var requestType: RequestTypes?
    
    init(){}
    
    func reset() {
        RequestManager.instance = RequestManager()
    }
    
    func mockRequest() {
        requestType = .mock
    }
    
    func session(httpRequest: HttpRequest, completion: @escaping (Result<Data, RequestError>) -> ()) {
        if requestType != .mock {
            SessionManager.instance.startSession(httpRequest: httpRequest) { (result) in
                completion(result)
            }
        } else {
            //Use the Mock jason to mimic the API response data
            if let path = Bundle.main.path(forResource: httpRequest.endpoint?.mockJson, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     completion(.success(data))
                  } catch {
                    Logger.log(error: .fileNotFound)
                    completion(.failure(.fileNotFound))
                  }
            } else {
                Logger.log(error: .wrongPath)
                completion(.failure(.wrongPath))
            }
        }
    }
    
    func downloadImage(imageURL: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: imageURL)
                if let downloadedImage = UIImage(data: data) {
                    
                    //Caching Image
                    Cache.saveImage(teamId: imageURL.absoluteString, image: downloadedImage)
                    
                    DispatchQueue.main.async {
                        completion(.success(downloadedImage))
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = RequestError.unknown
                        Logger.log(error: .emptyData, info: "Error trying to transform data fetched in UIImage: \(imageURL.absoluteString)")
                        completion(.failure(error))
                        return
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    Logger.log(error: error, info: "Error Trying to download image from server using URL: \(imageURL.absoluteString)")
                    completion(.failure(error))
                    return
                }
            }
        }
        
    }
    
}
