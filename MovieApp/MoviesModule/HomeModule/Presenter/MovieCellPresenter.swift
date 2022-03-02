//
//  MovieCellPresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation

class MovieCellPresenter: MovieCellPresenterProtocol {
    
    weak var view: MovieCellProtocol?
    
    required init(view: MovieCellProtocol) {
        self.view = view
    }
    
    func configure(movie: Movie) {
        let title = movie.title
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        guard let date = dateFormatterGet.date(from: movie.releaseDate) else { return }
        let releaseDate = dateFormatterPrint.string(from: date)
        
        let image = movie.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
        
        view?.setData(title: title, releaseDate: releaseDate, imageURL: url)
    }
}
