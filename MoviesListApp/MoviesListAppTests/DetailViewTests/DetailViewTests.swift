//
//  DetailViewTests.swift
//  MoviesListAppTests
//
//  Created by Manish Dabhi on 07/08/22.
//

import XCTest
@testable import MoviesListApp

//MARK: - DetailViewTests
class DetailViewTests: XCTestCase {

    var viewModel: DetailViewModel?
    var mockMoviesManager: MoviesManagerProtocol!
    
    var delegate: MockDetailViewModel = MockDetailViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSuccessfullyFetchPopularMovies() {
        viewModel = makeViewModel(with: 616037)
        let expectation = expectation(description: "Waiting for fetch movies detail")
        viewModel?.fetchMovieDetail()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssert(delegate.finishWithSuccess, "Movie detail is available")
    }
    
    func testFailedFetchPopularMovies() {
        viewModel = makeViewModel(with: 616037, error: .unauthorized)
        let expectation = expectation(description: "Waiting for fetch movies detail")
        viewModel?.fetchMovieDetail()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(delegate.errorMessage == RequestError.unauthorized.localizedDescription)
    }
    
    func testMovieDetailIsNotNil() {
        viewModel = makeViewModel(with: 616037, error: .unauthorized)
        let expectation = expectation(description: "Waiting for fetch movies detail")
        viewModel?.fetchMovieDetail()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertNotNil(delegate.movieDetailModel, "Movie detail is not nil")
    }
}

// MARK: - Helper
extension DetailViewTests {
    func makeViewModel(with movieId: Int? = nil, error: RequestError? = nil) -> DetailViewModel {
        let mockMoviesManager = MockMoviesManager(updateError: error)
        return DetailViewModel(movieId: movieId ?? 0,
                               detailViewModelDelegate: delegate,
                               moviesManager: mockMoviesManager)
    }
}

//MARK: - MockDetailViewModel
class MockDetailViewModel: NSObject, DetailViewModelDelegate {
    var finishWithSuccess = false
    var finishWithErrorOccurred = false
    var errorMessage: String = ""
    var movieDetailModel: MovieModel? = nil
    
    func updateUI(with movieModel: MovieModel) {
        movieDetailModel = movieModel
        finishWithSuccess = true
    }
    
    func movieFetchError(error: String) {
        finishWithErrorOccurred = true
        errorMessage = error
    }
}
