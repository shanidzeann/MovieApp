//
//  DetailViewProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol DetailViewProtocol: ViewProtocol {
    var presenter: DetailViewPresenterProtocol!  { get set }
    func updateCast()
    func setDetails(_ details: String)
    func setData(posterUrl: URL?, title: String, rating: String, description: String?)
    func disableWatchButton()
}
