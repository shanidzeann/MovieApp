//
//  CastCellPresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation


class CastCellPresenter: CastCellPresenterProtocol {
    
    weak var view: CastCellProtocol?
    
    required init(view: CastCellProtocol) {
        self.view = view
    }
    
    func configure(with cast: Cast) {
        var url: URL?
        if let profile = cast.profilePath {
            url = URL(string: "https://image.tmdb.org/t/p/w500\(profile)")
        }
        let name = cast.name
        let character = cast.character
        view?.setData(profileUrl: url, name: name, character: character)
    }
}
