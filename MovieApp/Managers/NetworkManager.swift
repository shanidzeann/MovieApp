//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import Foundation

class NetworkManager {
    
    let popularMoviesURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(yourKey)&language=en-US&page=1")
    let topRatedURL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(yourKey)&language=en-US&page=1")
    let upcomingURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(yourKey)&language=en-US&page=1")
    
    func downloadUrls(completion: @escaping (Result<[List], Error>) -> Void) {
        guard let popularMoviesURL = popularMoviesURL,
              let topRatedURL = topRatedURL,
              let upcoming = upcomingURL else { return }
        
        let urls = [popularMoviesURL, topRatedURL, upcoming]
        var movieCollection: [List] = []
        let urlDownloadQueue = DispatchQueue(label: "com.urlDownloader.urlqueue")
        let urlDownloadGroup = DispatchGroup()
        
        urls.forEach { url in
            urlDownloadGroup.enter()
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data,
                      let result = try? JSONDecoder().decode(List.self, from: data) else {
                          completion(.failure(error!))
                          urlDownloadQueue.async {
                              urlDownloadGroup.leave()
                          }
                          return
                      }
                
                urlDownloadQueue.async {
                    movieCollection.append(result)
                    urlDownloadGroup.leave()
                }
            }.resume()
            urlDownloadGroup.wait()
        }
        
        urlDownloadGroup.notify(queue: DispatchQueue.global()) {
            completion(.success(movieCollection))
        }
    }
}
