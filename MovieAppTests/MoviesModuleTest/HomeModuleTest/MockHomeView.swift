//
//  MockView.swift
//  MovieAppTests
//
//  Created by Anna Shanidze on 04.03.2022.
//

import Foundation
@testable import MovieApp

class MockHomeView: HomeViewProtocol {
    
    var presenter: HomeViewPresenterProtocol!
    
    func setMovies() {
    }
    
    func showError(error: Error) {
    }
}
