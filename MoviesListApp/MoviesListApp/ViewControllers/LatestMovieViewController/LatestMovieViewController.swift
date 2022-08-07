//
//  LatestMovieViewController.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import UIKit

//MARK: - LatestMovieViewController
class LatestMovieViewController: BaseViewController {

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var noMovieFoundLabel: UILabel!
    
    private var viewModel: LatestMovieViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        viewModel = LatestMovieViewModel(latestMovieViewModelDelegate: self)
        hideNoRecoredLabel(with: false)
        showLoadingView()
        viewModel?.fetchLatestMovies()
        setupMovieTableView()
    }
    
    private func setupMovieTableView() {
        movieTableView.registerCell(MovieListTableViewCell.self)
        movieTableView.sectionHeaderTopPadding()
        movieTableView.removeHeaderFooterBackgroundColor()
    }
    
    private func openMovieDetailView(with movieId: Int) {
        let detailViewController = Storyboard.Main.instantiateViewController(withViewClass: DetailViewController.self)
        detailViewController.movieId = movieId
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    private func hideNoRecoredLabel(with hide: Bool) {
        movieTableView.isHidden = !hide
        noMovieFoundLabel.isHidden = hide
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension LatestMovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.latestMovie.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MovieListTableViewCell.self, for: indexPath)
        cell.configuration(with: viewModel?.latestMovie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openMovieDetailView(with: viewModel?.latestMovie[indexPath.row]?.movieId ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - MovieListViewModelDelegate
extension LatestMovieViewController: LatestMovieViewModelDelegate {
    func reloadLatestMoviesTableView() {
        DispatchQueue.main.async {
            self.hideNoRecoredLabel(with: true)
            self.hideLoadingView()
            self.movieTableView.reloadData()
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
