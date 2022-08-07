//
//  DetailViewController.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 07/08/22.
//

import UIKit

//MARK: - DetailViewController
class DetailViewController: BaseViewController {

    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var noMovieFoundLabel: UILabel!
    
    private var viewModel: DetailViewModelProtocol?
    var movieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.tabBarController?.tabBar.isHidden = true
        hideNoRecoredLabel(with: false)
        showLoadingView()
        viewModel = DetailViewModel(movieId: movieId, detailViewModelDelegate: self)
        viewModel?.fetchMovieDetail()
    }

    private func updateDetailUI(with movieModel: MovieModel) {
        titleLabel.text = movieModel.title
        overviewLabel.text = movieModel.synopsis
        ratingLabel.text = String(format: "%.2f", movieModel.voteAverage ?? 0.0)
        
        if let imagePath = movieModel.image {
            if let imageUrl = URL(string: ApiConstant.imageURL + imagePath) {
                movieImageView.loadImage(url: imageUrl, placeholder: UIImage(named: "placeholderMovie"))
            }
        } else {
            movieImageView.image = UIImage(named: "placeholderMovie")
        }
        
        if let date = DateFormatter.date(from: movieModel.releaseDate ?? "", format: "YYYY-MM-DD") {
            releaseDateLabel.text = DateFormatter.string(from: date, format: "MMMM DD YYYY")
            releaseDateLabel.layoutIfNeeded()
        } else {
            releaseDateLabel.text = ""
        }
        hideNoRecoredLabel(with: true)
        self.hideLoadingView()
    }
    
    private func hideNoRecoredLabel(with hide: Bool) {
        detailScrollView.isHidden = !hide
        noMovieFoundLabel.isHidden = hide
    }
}

// MARK: - MovieListViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func updateUI(with movieModel: MovieModel) {
        DispatchQueue.main.async {
            self.updateDetailUI(with: movieModel)
        }
    }
    
    func movieFetchError(error: String) {
        DispatchQueue.main.async {
            self.hideNoRecoredLabel(with: false)
            self.hideLoadingView()
            self.showError(error: error)
        }
    }
}
