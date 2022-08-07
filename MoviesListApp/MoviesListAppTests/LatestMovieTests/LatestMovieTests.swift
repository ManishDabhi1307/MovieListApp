//
//  MoviesListTests.swift
//  MoviesListAppTests
//
//  Created by Manish Dabhi on 07/08/22.
//

import XCTest
@testable import MoviesListApp

//MARK: - LatestMovieTests
class LatestMovieTests: XCTestCase {

    var viewModel: LatestMovieViewModel?
    var mockMoviesManager: MoviesManagerProtocol!
    
    var delegate: MockLatestMovieViewModel = MockLatestMovieViewModel()
    
    override func setUp() {
        super.setUp()
        viewModel = makeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testSuccessfullyFetchLatestMovies() {
        let expectation = expectation(description: "Waiting for fetch latest movies")
        viewModel?.fetchLatestMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssert(delegate.finishWithSuccess, "Latest movie list is available")
    }
    
    func testFailedFetchLatestMovies() {
        viewModel = makeViewModel(with: .unauthorized)
        let expectation = expectation(description: "Waiting for fetch latest movies")
        viewModel?.fetchLatestMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(delegate.errorMessage == RequestError.unauthorized.localizedDescription)
    }
    
    func testLatestMoviesCount() {
        let expectation = expectation(description: "Waiting for fetch latest movies")
        viewModel?.fetchLatestMovies()
        expectation.fulfill()
        waitForExpectations(timeout: 5)
        
        XCTAssertTrue(viewModel?.latestMovie.count == 1)
    }
}

// MARK: - Helper
extension LatestMovieTests {
    func makeViewModel(with error: RequestError? = nil) -> LatestMovieViewModel {
        let mockMoviesManager = MockMoviesManager(updateError: error)
        return LatestMovieViewModel(latestMovieViewModelDelegate: delegate,
                                         moviesManager: mockMoviesManager)
    }
}

//MARK: - MockLatestMovieViewModel
class MockLatestMovieViewModel: NSObject, LatestMovieViewModelDelegate {
    var finishWithSuccess = false
    var finishWithErrorOccurred = false
    var errorMessage: String = ""
    
    func reloadLatestMoviesTableView() {
        finishWithSuccess = true
    }
    
    func movieFetchError(error: String) {
        finishWithErrorOccurred = true
        errorMessage = error
    }
}


