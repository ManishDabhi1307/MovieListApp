//
//  MoviesRouter.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

enum MoviesRouter {
    case getLatestMovie
    case getPopularMovie(page: Int)
    case movieDetail(id: Int)
}

extension MoviesRouter: HttpRouter {
    var path: String {
        switch self {
        case .getLatestMovie:
            return "/3/movie/latest"
        case .getPopularMovie:
            return "/3/movie/popular"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getLatestMovie,
                .getPopularMovie,
                .movieDetail:
            return .get
        }
    }
    
    var header: [String: String]? {
        switch self {
        case .getLatestMovie,
                .getPopularMovie,
                .movieDetail:
            return [
                "Authorization": "Bearer \(ApiConstant.accessToken)",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getLatestMovie,
                .getPopularMovie,
                .movieDetail:
            return nil
        }
    }
    
    var urlParameter: [String: String]? {
        switch self {
        case .getLatestMovie,
                .movieDetail:
            return nil
        case .getPopularMovie(let page):
            return ["page": String(page)]
        }
    }
}
