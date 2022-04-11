//
//  NetworkingTest.swift
//  MovieAppTests
//
//  Created by Anna Shanidze on 11.04.2022.
//

import XCTest
@testable import MovieApp

class NetworkingTest: XCTestCase {

    var networkManager: NetworkManagerProtocol!
    
    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testGetMoviesSuccess() {
        let moviesExpectation = expectation(description: "movies")
        
        networkManager.downloadMovies { result in
            switch result {
            case .success(let lists):
                XCTAssertNotNil(lists)
                moviesExpectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
