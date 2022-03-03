//
//  AssemblyBuilderProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createHomeModule(router: MoviesRouterProtocol) -> UIViewController
    func createDetailModule(movie: Movie?, router: MoviesRouterProtocol) -> UIViewController
    func createNavController(for rootViewController: UIViewController & ViewProtocol,
                             title: String,
                             image: UIImage) -> UIViewController
}
