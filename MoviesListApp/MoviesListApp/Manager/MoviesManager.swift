//
//  MoviesManager.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

protocol MoviesManagerProtocol {
    func getLatestMovie(completion: @escaping (Result<MovieModel, RequestError>) -> ())
    func getPopularMovie(with pageNumber: Int, completion: @escaping (Result<PopularMovieModel, RequestError>) -> ())
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieModel, RequestError>) -> ())
}

struct MoviesManager: NetworkManager, MoviesManagerProtocol {
    func getLatestMovie(completion: @escaping (Result<MovieModel, RequestError>) -> ()) {
        sendRequest(endpoint: MoviesRouter.getLatestMovie, responseModel: MovieModel.self, completion: completion)
    }
    
    func getPopularMovie(with pageNumber: Int, completion: @escaping (Result<PopularMovieModel, RequestError>) -> ()) {
        sendRequest(endpoint: MoviesRouter.getPopularMovie(page: pageNumber), responseModel: PopularMovieModel.self, completion: completion)
    }
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieModel, RequestError>) -> ()) {
        sendRequest(endpoint: MoviesRouter.movieDetail(id: id), responseModel: MovieModel.self, completion: completion)
    }
}
