//
//  HttpRouter.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol HttpRouter {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var urlParameter: [String: String]? { get }
}

extension HttpRouter {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.themoviedb.org"
    }
}



