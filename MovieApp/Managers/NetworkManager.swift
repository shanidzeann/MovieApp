//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import Foundation
import Kingfisher
import UIKit

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
                          if let error = error {
                              completion(.failure(error))
                          }
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
    
    func downloadCast(id: Int, completion: @escaping (Result<[Cast], Error>) -> Void) {
        guard let creditsURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(yourKey)&language=en-US") else { return }
        
        let task = URLSession.shared.dataTask(with: creditsURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Credits.self, from: data)
                    completion(.success(result.cast))
                } catch {
                        completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func downloadDetails(id: Int, completion: @escaping (Result<Details, Error>) -> Void) {
        guard let creditsURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(yourKey)&language=en-US") else { return }
        
        let task = URLSession.shared.dataTask(with: creditsURL) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Details.self, from: data)
                    completion(.success(result))
                } catch {
                        completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
