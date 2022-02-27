//
//  HomeViewPresenterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation


protocol HomeViewPresenterProtocol: AnyObject {
    init(view: HomeViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol)
    func setMovies()
    var lists: [List]? { get set }
    func tapOnMovie(movie: Movie?)
}
