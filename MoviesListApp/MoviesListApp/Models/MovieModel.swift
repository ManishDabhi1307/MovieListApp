//
//  MovieModel.swift
//  MoviesListApp
//
//  Created by Manish Dabhi on 05/08/22.
//

import Foundation

//MARK: - MovieModel
struct MovieModel: Codable {
    var title: String?
    var popularity: Double?
    var movieId: Int?
    var voteCount: Int?
    var originalTitle: String?
    var voteAverage: Double?
    var synopsis: String?
    var releaseDate: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case voteCount = "vote_count"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case synopsis = "overview"
        case releaseDate = "release_date"
        case image = "poster_path"
        case title, popularity
    }
}

//MARK: - PopularMovieModel
struct PopularMovieModel: Codable {
    var page: Int?
    var results: [MovieModel]?
    var totalResults: Int?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results, page
    }
}
