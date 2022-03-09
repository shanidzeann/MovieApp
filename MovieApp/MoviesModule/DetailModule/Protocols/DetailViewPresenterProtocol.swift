//
//  DetailViewPresenterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewController, networkManager: NetworkManagerProtocol, router: MoviesRouterProtocol, movie: Movie?)
    var cast: [Cast]? { get set }
    func setData()
    func numberOfItemsInSection() -> Int
    func cast(for indexPath: IndexPath) -> Cast?
    func backToHome()
    func showMovie()
    func checkWatchButtonActivity()
}
