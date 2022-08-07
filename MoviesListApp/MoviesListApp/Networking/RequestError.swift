//
//  RequestError.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

enum RequestError: LocalizedError {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return MessageConstants.decodeError
        case .unauthorized:
            return MessageConstants.sessionExpired
        default:
            return MessageConstants.unknownError
        }
    }
}
