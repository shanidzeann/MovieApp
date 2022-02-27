//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation


class HomePresenter: HomeViewPresenterProtocol {

    weak var view: HomeViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var lists: [List]?
    

    required init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }

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
    
    func tapOnMovie(movie: Movie?) {
        router?.showDetail(movie: movie)
    }


}
