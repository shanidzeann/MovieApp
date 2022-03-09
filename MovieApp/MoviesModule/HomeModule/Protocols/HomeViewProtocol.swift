//
//  HomeViewProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol HomeViewProtocol: ViewProtocol {
    var presenter: HomeViewPresenterProtocol!  { get set }
    func setMovies()
    func showError(error: Error) 
}
