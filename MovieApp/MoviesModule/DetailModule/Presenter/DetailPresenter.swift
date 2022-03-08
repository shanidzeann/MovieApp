//
//  DetailPresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation


class DetailPresenter: DetailViewPresenterProtocol {
    
    // MARK: - Properties
    
    let imageURL = "https://image.tmdb.org/t/p/w500"
    weak var view: DetailViewProtocol?
    var router: MoviesRouterProtocol?
    let networkManager: NetworkManagerProtocol!
    var movie: Movie?
    var cast: [Cast]?
    var details: Details?
    
    // MARK: - Init
    
    required init(view: DetailViewController, networkManager: NetworkManagerProtocol, router: MoviesRouterProtocol, movie: Movie?) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        self.movie = movie
    }
    
    // MARK: - Methods
    
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
        
        let image = movie.backdropPath
        let url = URL(string: imageURL + image)
        let title = movie.title
        let rating = "\(movie.voteAverage)"
        let description = movie.overview
        
        
        view?.setData(posterUrl: url, title: title, rating: rating, description: description)
    }
    
    func numberOfItemsInSection() -> Int {
        return cast?.count ?? 0
    }
    
    func cast(for indexPath: IndexPath) -> Cast? {
        return cast?[indexPath.item]
    }
    
    func backToHome() {
        router?.backToHome(from: view)
    }
    
    func showMovie() {
        guard let details = details,
              let homePageURL = details.homepage,
              let url = URL(string: homePageURL) else { return }
        router?.openInSafari(url: url)
    }
    
    // MARK: - Private
    
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
        networkManager.downloadData(.credits, id: movieId) { [weak self] (result: Result<Credits, Error>) in
            switch result {
            case .success(let credits):
                self?.cast = credits.cast
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getDetails(from movieId: Int, completion: @escaping () -> Void) {
        details = nil
        networkManager.downloadData(.details, id: movieId) { [weak self] (result: Result<Details, Error>) in
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



