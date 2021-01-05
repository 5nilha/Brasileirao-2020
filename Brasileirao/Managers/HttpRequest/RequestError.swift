//
//  RequestErrors.swift
//  Brasileirao
//
//  Created by Fabio Quintanilha on 11/6/20.
//  Copyright © 2020 Fabio Quintanilha. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case emptyData
    case wrongPath
    case fileNotFound
    case unauthorized
    case invalidURL
    case badRequest
    case emptyURL
    case decodedError
    case serverError
    case serverUnavailable
    case unknown
    
    init(httpStatusCode: Int) {
        switch httpStatusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 404:
            self = .invalidURL
        case 500:
            self = .serverError
        case 503:
            self = .serverUnavailable
        default:
            self = .unauthorized
        }
    }
    
    var title: String {
        return "error_title".localized
    }
    
    var UIDescription: String {
        return "error_UIDescription".localized
        
    }
    
    var description: String {
        switch self {
        case .emptyData:
            return "nil_data_error".localized
        case .fileNotFound:
            return "file_not_found_error".localized
        case .decodedError:
            return "decode_error".localized
        case .unauthorized:
            return "unauthorized_token_error".localized
        case .invalidURL:
            return "invalid_url".localized
        case .emptyURL:
            return "nil_url".localized
        case .wrongPath:
            return "wrongPath".localized
        case .badRequest:
            return "badRequest".localized
        case .serverError:
            return "serverError".localized
        case .serverUnavailable:
            return"serverUnavailable".localized
        case .unknown:
            return self.localizedDescription
        }
    }
}
