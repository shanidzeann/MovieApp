//
//  MovieCellPresenterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation

protocol MovieCellPresenterProtocol {
    func configure(movie: Movie)
    init(view: MovieCellProtocol)
}
