//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation


class DetailPresenter: DetailViewPresenterProtocol {
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var movie: Movie?
    var cast: [Cast]?
    var details: Details?
    
    required init(view: DetailViewController, networkManager: NetworkManagerProtocol, router: RouterProtocol, movie: Movie?) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        self.movie = movie
    }
    
    func setData() {
        guard let movie = movie else { return }
        getCast(from: movie.id) {
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateCast()
            }
        }
        
        getDetails(from: movie.id) {
            DispatchQueue.main.async { [weak self] in
                self?.setDetails()
            }
        }
        
        view?.setData(movie: movie)
    }
    
    
    private func setDetails() {
        guard let details = details else { return }

        let releaseDate = details.releaseDate.prefix(4)
       
        let interval = details.runtime * 60
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        guard let runtime = formatter.string(from: TimeInterval(interval)) else { return }
        
        var allGenres = ""
        for genre in details.genres {
            allGenres.append(genre.name)
            if genre.name != details.genres.last?.name {
                allGenres += ", "
            }
        }
        
        let allDetails = releaseDate + " · " + allGenres + " · " + runtime
        view?.setDetails(allDetails)
    }

    private func getCast(from movieId: Int, completion: @escaping () -> Void) {
        cast = nil
        networkManager.downloadCast(id: movieId) { [weak self] result in
            switch result {
            case .success(let cast):
                self?.cast = cast
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getDetails(from movieId: Int, completion: @escaping () -> Void) {
        details = nil
        networkManager.downloadDetails(id: movieId) { [weak self] result in
            switch result {
            case .success(let details):
                self?.details = details
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}



