//
//  DetailViewModel.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 07/08/22.
//

import Foundation

//MARK: - DetailViewModelDelegate
protocol DetailViewModelDelegate: AnyObject {
    func updateUI(with movieModel: MovieModel)
    func movieFetchError(error: String)
}

//MARK: - DetailViewModelProtocol
protocol DetailViewModelProtocol: AnyObject {
    func fetchMovieDetail()
}

//MARK: - DetailViewModel
class DetailViewModel: DetailViewModelProtocol {
    private var movieId: Int = 0
    
    weak var detailViewModelDelegate: DetailViewModelDelegate?
    var moviesManager: MoviesManagerProtocol?
    
    init(movieId: Int,
         detailViewModelDelegate: DetailViewModelDelegate,
         moviesManager: MoviesManagerProtocol = MoviesManager()) {
        self.moviesManager = moviesManager
        self.detailViewModelDelegate = detailViewModelDelegate
        self.movieId = movieId
    }
    
    func fetchMovieDetail() {
        moviesManager?.getMovieDetail(id: movieId, completion: { [weak self] result in
            switch result {
            case .success(let movieResponse):
                self?.setMovieDetailData(model: movieResponse)
            case .failure(let error):
                self?.detailViewModelDelegate?.movieFetchError(error: error.localizedDescription)
            }
        })
    }
}

//MARK: - DetailViewModel
extension DetailViewModel {
    private func setMovieDetailData(model: MovieModel) {
        self.detailViewModelDelegate?.updateUI(with: model)
    }
}
