//
//  HomePresenterTest.swift
//  MovieAppTests
//
//  Created by Anna Shanidze on 04.03.2022.
//

import XCTest
@testable import MovieApp

class HomePresenterTest: XCTestCase {
    
    var presenter: HomePresenter!
    var networkManager: NetworkManagerProtocol!
    var router: MoviesRouterProtocol!
    var lists = [(url: String, movies: List)]()
    var view: MockHomeView!
    
    override func setUpWithError() throws {
        view = MockHomeView()
        let assemblyBuilder = AssemblyModuleBuilder()
        router = MoviesRouter(viewController: view, assemblyBuilder: assemblyBuilder)
    }
    
    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        presenter = nil
    }
    
    func testGetSuccessMovieLists() {
        let movie = Movie(adult: nil, backdropPath: "", genreIDS: [1], id: 1, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "", releaseDate: "", title: "", video: nil, voteAverage: 1.0, voteCount: 1)
        let movies = List(dates: nil, page: 1, results: [movie], totalPages: 1, totalResults: 1)
        lists.append((url: "Foo", movies: movies))
        networkManager = MockNetworkManager(lists: lists)
        presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        
        presenter.setMovies()
        let listsCount = presenter.lists?.count
        
        XCTAssertNotNil(listsCount)
        XCTAssertNotEqual(listsCount, 0)
    }
    
    
    func testGetFailureMovieLists() {
        networkManager = MockNetworkManager()
        presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        
        presenter.setMovies()
        XCTAssertNil(presenter.lists)
    }
}
