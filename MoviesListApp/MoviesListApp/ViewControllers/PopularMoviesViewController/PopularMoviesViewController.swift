//
//  PopularMoviesViewController.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 07/08/22.
//

import UIKit

//MARK: - PopularMoviesViewController
class PopularMoviesViewController: BaseViewController {

    @IBOutlet weak var popularMovieTableView: UITableView!
    @IBOutlet weak var noMovieFoundLabel: UILabel!
    
    private var viewModel: PopularMovieViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        viewModel = PopularMovieViewModel(popularMovieViewModelDelegate: self)
        hideNoRecoredLabel(with: false)
        showLoadingView()
        viewModel?.fetchPopularMovies()
        
        setupMovieTableView()
    }
    
    private func setupMovieTableView() {
        popularMovieTableView.registerCell(MovieListTableViewCell.self)
        popularMovieTableView.sectionHeaderTopPadding()
        popularMovieTableView.removeHeaderFooterBackgroundColor()
    }
    
    private func openMovieDetailView(with movieId: Int) {
        let detailViewController = Storyboard.Main.instantiateViewController(withViewClass: DetailViewController.self)
        detailViewController.movieId = movieId
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func hideNoRecoredLabel(with hide: Bool) {
        popularMovieTableView.isHidden = !hide
        noMovieFoundLabel.isHidden = hide
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.popularMovie.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MovieListTableViewCell.self, for: indexPath)
        cell.configuration(with: viewModel?.popularMovie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openMovieDetailView(with: viewModel?.popularMovie[indexPath.row]?.movieId ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.popularMovie.count ?? 0) - 1 {
            self.showLoadingView()
            viewModel?.fetchPopularMovies()
        }
    }
}

// MARK: - MovieListViewModelDelegate
extension PopularMoviesViewController: PopularMovieViewModelDelegate {
    func reloadPopularMoviesTableView() {
        DispatchQueue.main.async {
            self.hideNoRecoredLabel(with: true)
            self.hideLoadingView()
            self.popularMovieTableView.reloadData()
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
