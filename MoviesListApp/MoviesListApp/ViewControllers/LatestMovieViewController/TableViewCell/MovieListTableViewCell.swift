//
//  MovieListTableViewCell.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 06/08/22.
//

import UIKit

//MARK: - MovieListTableViewCell
class MovieListTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var movieIconImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configuration(with movieListData: MovieModel?) {
        guard let movieListData = movieListData else { return }
        movieTitleLabel.text = movieListData.title
        movieSynopsis.text = movieListData.synopsis
        if let imagePath = movieListData.image {
            if let imageUrl = URL(string: ApiConstant.imageURL + imagePath) {
                movieIconImageView.loadImage(url: imageUrl, placeholder: UIImage(named: "placeholderMovie"))
            }
        } else {
            movieIconImageView.image = UIImage(named: "placeholderMovie")
        }
        
        if let date = DateFormatter.date(from: movieListData.releaseDate ?? "", format: "YYYY-MM-DD") {
            releaseDateLabel.text = DateFormatter.string(from: date, format: "MMMM DD YYYY")
            releaseDateLabel.layoutIfNeeded()
        } else {
            releaseDateLabel.text = ""
        }
    }
}
