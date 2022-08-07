//
//  LatestMovieTests.swift
//  MoviesListAppTests
//
//  Created by Manish Dabhi on 07/08/22.
//

import XCTest
@testable import MoviesListApp

//MARK: - PopularMovieTests
class PopularMovieTests: XCTestCase {

    var viewModel: PopularMovieViewModel?
    var mockMoviesManager: MoviesManagerProtocol!
    
    var delegate: MockPopularMovieViewModel = MockPopularMovieViewModel()
    
    override func setUp() {
        super.setUp()
        viewModel = makeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSuccessfullyFetchPopularMovies() {
        let expectation = expectation(description: "Waiting for fetch popular movies")
        viewModel?.fetchPopularMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssert(delegate.finishWithSuccess, "Popular movie list is available")
    }
    
    func testFailedFetchPopularMovies() {
        viewModel = makeViewModel(with: .unauthorized)
        let expectation = expectation(description: "Waiting for fetch popular movies")
        viewModel?.fetchPopularMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(delegate.errorMessage == RequestError.unauthorized.localizedDescription)
    }
    
    func testPopularMoviesCount() {
        let expectation = expectation(description: "Waiting for fetch popular movies")
        viewModel?.fetchPopularMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(viewModel?.popularMovie.count == 2)
    }
}

// MARK: - Helper
extension PopularMovieTests {
    func makeViewModel(with error: RequestError? = nil) -> PopularMovieViewModel {
        let mockMoviesManager = MockMoviesManager(updateError: error)
        return PopularMovieViewModel(popularMovieViewModelDelegate: delegate,
                                         moviesManager: mockMoviesManager)
    }
}

//MARK: - MockPopularMovieViewModel
class MockPopularMovieViewModel: NSObject, PopularMovieViewModelDelegate {
    var finishWithSuccess = false
    var finishWithErrorOccurred = false
    var errorMessage: String = ""
    
    func reloadPopularMoviesTableView() {
        finishWithSuccess = true
    }
    
    func movieFetchError(error: String) {
        finishWithErrorOccurred = true
        errorMessage = error
    }
}
