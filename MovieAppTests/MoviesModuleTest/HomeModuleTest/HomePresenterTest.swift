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
        
        let movie = Movie(adult: nil, backdropPath: "", genreIDS: [1], id: 1, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "", releaseDate: "", title: "", video: nil, voteAverage: 1.0, voteCount: 1)
        let movies = List(dates: nil, page: 1, results: [movie], totalPages: 1, totalResults: 1)
        lists.append((url: "Foo", movies: movies))
    }
    
    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        presenter = nil
    }
    
    func testSetMovieListsSuccess() {
        setUpWithMovies()
        
        let listsCount = presenter.lists?.count
        
        XCTAssertNotNil(listsCount)
        XCTAssertNotEqual(listsCount, 0)
    }
    
    func testSetMovieListsFailure() {
        setUpWithoutMovies()
        
        XCTAssertNil(presenter.lists)
    }
    
    func testGetSelectedMovieSuccess() {
        setUpWithMovies()
        
        let indexPath = IndexPath(item: 0, section: 0)
        let selectedMovie = presenter.movie(for: indexPath)
        
        XCTAssertNotNil(selectedMovie)
        XCTAssertEqual(selectedMovie!.id, 1)
    }
    
    func testGetSelectedMovieFailure() {
        setUpWithoutMovies()
        
        let indexPath = IndexPath(item: 0, section: 0)
        let selectedMovie = presenter.movie(for: indexPath)
        XCTAssertNil(selectedMovie)
    }
    
    func testGetNumberOfSectionsAndItemsInSectionSuccess() {
        setUpWithMovies()
        
        let items = presenter.numberOfItemsInSection(0)
        let sections = presenter.numberOfSections()
        
        XCTAssertEqual(sections, 1)
        XCTAssertEqual(items, 1)
    }
    
    func testGetNumberOfSectionsAndItemsInSectionFailure() {
        setUpWithoutMovies()
        
        let items = presenter.numberOfItemsInSection(0)
        let sections = presenter.numberOfSections()
        
        XCTAssertEqual(sections, 0)
        XCTAssertEqual(items, 0)
    }
    
    func testGetUrlForSectionSuccess() {
        setUpWithMovies()
        
        let url = presenter.urlFor(section: 0)
        
        XCTAssertEqual(url, "Foo")
    }
    
    func testGetUrlForSectionFailure() {
        setUpWithoutMovies()
        
        let url = presenter.urlFor(section: 0)
        
        XCTAssertEqual(url, "")
    }
    
    private func setUpWithMovies() {
        networkManager = MockNetworkManager(lists: lists)
        presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        presenter.setMovies()
    }
    
    private func setUpWithoutMovies() {
        networkManager = MockNetworkManager()
        presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        presenter.setMovies()
    }
}
