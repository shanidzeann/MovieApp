//
//  AssemblyBuilderProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createHomeModule(_ view: HomeViewProtocol, router: MoviesRouterProtocol) -> UIViewController 
    func createDetailModule(movie: Movie?, router: MoviesRouterProtocol) -> UIViewController
    func createHomeViewController(_ view: HomeViewProtocol) -> UIViewController
    func createProfileViewController() -> UIViewController
}
