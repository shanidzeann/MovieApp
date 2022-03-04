//
//  MockNetworkManager.swift
//  MovieAppTests
//
//  Created by Anna Shanidze on 04.03.2022.
//

import Foundation
@testable import MovieApp

class MockNetworkManager: NetworkManagerProtocol {
    
    var lists: [(url: String, movies: List)]?
    
    init() {}
    
    convenience init(lists: [(url: String, movies: List)]?) {
        self.init()
        self.lists = lists
    }
    
    func downloadMovies(completion: @escaping (Result<[(url: String, movies: List)], Error>) -> Void) {
        if let lists = lists {
            completion(.success(lists))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    func downloadData<T>(_ type: DataType, id: Int, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
    }
}
