//
//  DetailViewPresenterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewController, networkManager: NetworkManagerProtocol, router: RouterProtocol, movie: Movie?)
    var cast: [Cast]? { get set }
    func setData()
    func numberOfItemsInSection() -> Int
    func cast(for indexPath: IndexPath) -> Cast?
}
