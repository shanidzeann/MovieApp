//
//  NetworkManagerProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func downloadMovies(completion: @escaping (Result<[List], Error>) -> Void)
    func downloadCast(id: Int, completion: @escaping (Result<[Cast], Error>) -> Void)
    func downloadDetails(id: Int, completion: @escaping (Result<Details, Error>) -> Void)
}
