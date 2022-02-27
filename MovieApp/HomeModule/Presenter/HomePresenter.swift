//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation


protocol HomeViewProtocol: AnyObject {
    var presenter: HomeViewPresenterProtocol!  { get set }
    func setMovies()
}

protocol HomeViewPresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol)
    func setMovies()
    var lists: [List]? { get set }
}

class HomePresenter: HomeViewPresenterProtocol {

    weak var view: HomeViewProtocol?
    //var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var lists: [List]?
    

    required init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
       // self.router = router
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


}
