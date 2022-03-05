//
//  MockDetailView.swift
//  MovieAppTests
//
//  Created by Anna Shanidze on 05.03.2022.
//

import Foundation
@testable import MovieApp

class MockDetailView: DetailViewProtocol {
    var presenter: DetailViewPresenterProtocol!
    
    func updateCast() {
        
    }
    
    func setDetails(_ details: String) {
        
    }
    
    func setData(posterUrl: URL?, title: String, rating: String, description: String?) {
        
    }
}
