//
//  AssemblyBuilderProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createHomeModule(_ viewController: UIViewController & HomeViewProtocol, router: MoviesRouterProtocol) -> UIViewController
    func createDetailModule(movie: Movie?, router: MoviesRouterProtocol) -> UIViewController
    func createHomeViewController(_ viewController: UIViewController & HomeViewProtocol) -> UIViewController
    func createProfileViewController() -> UIViewController
}
