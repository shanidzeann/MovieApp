//
//  ProfilePresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation


class ProfilePresenter: ProfileViewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: ProfileViewProtocol?
    var router: RouterMain?
    let networkManager: NetworkManagerProtocol!
    
    // MARK: - Init
    
    init(view: ProfileViewProtocol, networkManager: NetworkManagerProtocol, router: RouterMain) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
    }
    
    
}
