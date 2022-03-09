//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

class HomePresenter: HomeViewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: HomeViewProtocol?
    var router: MoviesRouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var lists: [(url: String, movies: List)]?
    
    // MARK: - Init
    
    required init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol, router: MoviesRouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }
    
    // MARK: - Helper Methods
    
    func setMovies() {
        networkManager.downloadMovies { [weak self] result in
            switch result {
            case .success(let lists):
                self?.lists = lists
                self?.view?.setMovies()
            case .failure(let error):
                self?.view?.showError(error: error)
            }
        }
    }
    
    func movie(for indexPath: IndexPath) -> Movie? {
        guard let movies = lists?[indexPath.section].movies.results else { return nil }
        return movies[indexPath.item]
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return lists?[section].movies.results.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return lists?.count ?? 0
    }
    
    func tapOnMovie(movie: Movie?) {
        router?.showDetail(movie: movie)
    }
    
    func urlFor(section: Int) -> String {
        return lists?[section].url ?? ""
    }
    
}
