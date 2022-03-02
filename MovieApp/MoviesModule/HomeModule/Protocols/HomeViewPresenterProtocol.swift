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
    var lists: [(url: String, movies: List)]? { get set }
    func tapOnMovie(movie: Movie?)
    func movie(for indexPath: IndexPath) -> Movie?
    func numberOfItemsInSection(_ section: Int) -> Int
    func numberOfSections() -> Int
    func urlFor(section: Int) -> String
}
