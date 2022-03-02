//
//  HomeHeaderPresenter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation

class HomeHeaderPresenter: HomeHeaderPresenterProtocol {
    weak var view: HomeHeaderProtocol?
    
    required init(view: HomeHeaderProtocol) {
        self.view = view
    }
    
    func setTitle(for urlString: String) {
        
        var headerTitle = ""
        
        if urlString.contains("popular") {
            headerTitle = "Popular Movie"
        } else if urlString.contains("top_rated") {
            headerTitle = "Top Rated"
        } else if urlString.contains("upcoming") {
            headerTitle = "Upcoming"
        }
        
        view?.setTitle(headerTitle)
    }
}
