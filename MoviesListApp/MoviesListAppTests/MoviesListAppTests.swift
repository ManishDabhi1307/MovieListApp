//
//  MoviesListAppTests.swift
//  MoviesListAppTests
//
//  Created by Manish Dabhi on 05/08/22.
//

import XCTest
@testable import MoviesListApp

class MoviesListAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
    }
}

extension XCTestCase {
    func await<T>(_ function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = self.expectation(description: "Async call")
        var result: T?
        
        function() { value in
            result = value
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
        guard let unwrappedResult = result else {
            throw RequestError.noResponse
        }
        
        return unwrappedResult
    }
}
