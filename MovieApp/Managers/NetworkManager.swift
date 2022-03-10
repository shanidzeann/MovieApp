//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import Foundation
import Kingfisher
import UIKit

class NetworkManager: NetworkManagerProtocol {
    
    let popularMoviesURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(yourKey)&language=en-US&page=1")
    let topRatedURL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(yourKey)&language=en-US&page=1")
    let upcomingURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(yourKey)&language=en-US&page=1")
    
    func downloadMovies(completion: @escaping (Result<[(url: String, movies: List)], Error>) -> Void) {
        guard let popularMoviesURL = popularMoviesURL,
              let topRatedURL = topRatedURL,
              let upcoming = upcomingURL else { return }
        
        let urls = [popularMoviesURL, topRatedURL, upcoming]
        var movieCollection: [(url: String, movies: List)] = []
        var catchError: Error?
        let urlDownloadQueue = DispatchQueue(label: "com.urlDownloader.urlqueue")
        let urlDownloadGroup = DispatchGroup()
        
        urls.forEach { url in
            urlDownloadGroup.enter()
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    catchError = error
                    self?.leaveGroup(urlDownloadGroup, queue: urlDownloadQueue)
                }
                if let data = data {
                    self?.parseJSON(data: data, completion: { (result: Result<List, Error>) in
                        switch result {
                        case .success(let result):
                            urlDownloadQueue.async {
                                movieCollection.append((url.absoluteString, result))
                                urlDownloadGroup.leave()
                            }
                        case .failure(let error):
                            catchError = error
                            self?.leaveGroup(urlDownloadGroup, queue: urlDownloadQueue)
                        }
                    })
                }
            }.resume()
            urlDownloadGroup.wait()
        }
        
        urlDownloadGroup.notify(queue: .main) {
            if movieCollection.isEmpty {
                completion(.failure(catchError!))
            } else {
                completion(.success(movieCollection))
            }
        }
    }
    
    private func leaveGroup(_ group: DispatchGroup, queue: DispatchQueue) {
        queue.async {
            group.leave()
        }
    }
    
    
    func downloadData<T: Decodable>(_ type: DataType, id: Int, completion: @escaping (Result<T, Error>) -> Void) {
        var url: URL?
        switch type {
        case .details:
            url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(yourKey)&language=en-US")
        case .credits:
            url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(yourKey)&language=en-US")
        }
        guard let url = url else { return }
        
        getData(url: url) { (result: Result<T, Error>) in
            switch result {
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                self?.parseJSON(data: data) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let array):
                        completion(.success(array))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void)  {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            completion(.failure(DecodingError.dataCorrupted(context)))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.keyNotFound(key, context)))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.valueNotFound(value, context)))
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.typeMismatch(type, context)))
        } catch {
            completion(.failure(error))
        }
    }
    
}
