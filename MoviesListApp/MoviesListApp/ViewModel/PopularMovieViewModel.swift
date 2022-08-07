//
//  PopularMovieViewModel.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 07/08/22.
//

import Foundation

//MARK: - PopularMovieViewModelDelegate
protocol PopularMovieViewModelDelegate: AnyObject {
    func reloadPopularMoviesTableView()
    func movieFetchError(error: String)
}

//MARK: - PopularMovieViewModelProtocol
protocol PopularMovieViewModelProtocol: AnyObject {
    var popularMovie: [MovieModel?] { get set }
    var popularMovieCurrentPage: Int {get set}
    
    func fetchPopularMovies()
}

//MARK: - PopularMovieViewModel
class PopularMovieViewModel: PopularMovieViewModelProtocol {
    var popularMovie: [MovieModel?]
    var popularMovieCurrentPage: Int
    
    weak var popularMovieViewModelDelegate: PopularMovieViewModelDelegate?
    var moviesManager: MoviesManagerProtocol?
    
    init(popularMovieViewModelDelegate: PopularMovieViewModelDelegate,
         moviesManager: MoviesManagerProtocol = MoviesManager()) {
        self.moviesManager = moviesManager
        self.popularMovieViewModelDelegate = popularMovieViewModelDelegate

        popularMovie = []
        popularMovieCurrentPage = 1
    }
    
    func fetchPopularMovies() {
        moviesManager?.getPopularMovie(with: popularMovieCurrentPage, completion: { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.setPopularMovieData(model: movieResponse.results ?? [])
            case .failure(let error):
                self?.popularMovieViewModelDelegate?.movieFetchError(error: error.localizedDescription)
            }
        })
    }
}

//MARK: - PopularMovieViewModel
extension PopularMovieViewModel {
    private func setPopularMovieData(model: [MovieModel]) {
        popularMovie.append(contentsOf: model)
        popularMovieCurrentPage = popularMovieCurrentPage + 1
        self.popularMovieViewModelDelegate?.reloadPopularMoviesTableView()
    }
}
