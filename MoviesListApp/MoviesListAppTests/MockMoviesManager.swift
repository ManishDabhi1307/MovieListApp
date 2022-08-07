//
//  MockMoviesManager.swift
//  MoviesListAppTests
//
//  Created by Manish Dabhi on 07/08/22.
//

import XCTest
@testable import MoviesListApp

//MARK: - MockMoviesManager
struct MockMoviesManager: MoviesManagerProtocol {
    var updateError: RequestError?
    
    //MARK: - getLatestMovie
    func getLatestMovie(completion: @escaping (Result<MovieModel, RequestError>) -> ()) {
        if let error = updateError {
            completion(.failure(error))
        }
        
        let jsonData = loadJson(filename: "LatestMovieList")
        let decoderObject = JSONDecoder()
        
        do {
            let decodedResponse = try decoderObject.decode(MovieModel.self, from: jsonData)
            completion(.success(decodedResponse))
        } catch {
            print(error)
            completion(.failure(.decode))
        }
    }
    
    //MARK: - getPopularMovie
    func getPopularMovie(with pageNumber: Int, completion: @escaping (Result<PopularMovieModel, RequestError>) -> ()) {
        if let error = updateError {
            completion(.failure(error))
        }
        
        let jsonData = loadJson(filename: "PopularMovieList")
        let decoderObject = JSONDecoder()
        
        do {
            let decodedResponse = try decoderObject.decode(PopularMovieModel.self, from: jsonData)
            completion(.success(decodedResponse))
        } catch {
            print(error)
            completion(.failure(.decode))
        }
    }
    
    //MARK: - getMovieDetail
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieModel, RequestError>) -> ()) {
        if let error = updateError {
            completion(.failure(error))
        }
        
        let jsonData = loadJson(filename: "MovieDetail")
        let decoderObject = JSONDecoder()
        
        do {
            let decodedResponse = try decoderObject.decode(MovieModel.self, from: jsonData)
            completion(.success(decodedResponse))
        } catch {
            print(error)
            completion(.failure(.decode))
        }
    }
}

//MARK: - MockMoviesManager
extension MockMoviesManager {
    func loadJson(filename fileName: String) -> Data {
         if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
             do {
                 let dataObj = try Data(contentsOf: url)
                 return dataObj
             } catch {
                 print("error:\(error)")
             }
         }
         return Data()
     }
}
