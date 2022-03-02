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
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var lists: [List]?
    
    // MARK: - Init

    required init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
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
                DispatchQueue.main.async {
                    self?.view?.setMovies()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func movie(for indexPath: IndexPath) -> Movie? {
        guard let movies = lists?[indexPath.section].results else { return nil }
        return movies[indexPath.item]
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return lists?[section].results.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return lists?.count ?? 0
    }
    
    func tapOnMovie(movie: Movie?) {
        router?.showDetail(movie: movie)
    }


}
