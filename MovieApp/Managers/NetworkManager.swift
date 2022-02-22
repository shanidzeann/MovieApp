//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import Foundation

class NetworkManager {
    
    let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(yourKey)&language=en-US&page=1"
    
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: popularMoviesURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(List.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
