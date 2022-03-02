//
//  NetworkManagerProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func downloadMovies(completion: @escaping (Result<[(url: String, movies: List)], Error>) -> Void)
    func downloadData<T: Decodable>(_ type: DataType, id: Int, completion: @escaping (Result<T, Error>) -> Void)
}
