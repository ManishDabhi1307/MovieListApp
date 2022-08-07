//
//  MovieListViewModel.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 06/08/22.
//

import Foundation

//MARK: - LatestMovieViewModelDelegate
protocol LatestMovieViewModelDelegate: AnyObject {
    func reloadLatestMoviesTableView()
    func movieFetchError(error: String)
}

//MARK: - LatestMovieViewModelProtocol
protocol LatestMovieViewModelProtocol: AnyObject {
    var latestMovie: [MovieModel?] {get set}
    func fetchLatestMovies()
}

//MARK: - LatestMovieViewModel
class LatestMovieViewModel: LatestMovieViewModelProtocol {
    
    var latestMovie: [MovieModel?]

    weak var latestMovieViewModelDelegate: LatestMovieViewModelDelegate?
    var moviesManager: MoviesManagerProtocol?
    
    init(latestMovieViewModelDelegate: LatestMovieViewModelDelegate,
         moviesManager: MoviesManagerProtocol = MoviesManager()) {
        self.moviesManager = moviesManager
        self.latestMovieViewModelDelegate = latestMovieViewModelDelegate
        
        latestMovie = []
    }
    
    func fetchLatestMovies() {
        moviesManager?.getLatestMovie(completion: { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.setLatestMovieData(model: movieResponse)
            case .failure(let error):
                self?.latestMovieViewModelDelegate?.movieFetchError(error: error.localizedDescription)
            }
        })
    }
}

//MARK: - LatestMovieViewModel
extension LatestMovieViewModel {
    private func setLatestMovieData(model: MovieModel) {
        latestMovie.append(model)
        self.latestMovieViewModelDelegate?.reloadLatestMoviesTableView()
    }
}


