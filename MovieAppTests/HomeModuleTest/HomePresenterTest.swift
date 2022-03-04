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
        
        var catchLists: [(url: String, movies: List)]?
        
        networkManager.downloadMovies { result in
            switch result {
            case .success(let lists):
                catchLists = lists
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertNotEqual(catchLists?.count, 0)
    }
    
    func testGetFailureMovieLists() {
        let movie = Movie(adult: nil, backdropPath: "", genreIDS: [1], id: 1, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: "", releaseDate: "", title: "", video: nil, voteAverage: 1.0, voteCount: 1)
        let movies = List(dates: nil, page: 1, results: [movie], totalPages: 1, totalResults: 1)
        lists.append((url: "Foo", movies: movies))
        networkManager = MockNetworkManager()
        presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        
        var catchError: Error?
        
        networkManager.downloadMovies { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
}
