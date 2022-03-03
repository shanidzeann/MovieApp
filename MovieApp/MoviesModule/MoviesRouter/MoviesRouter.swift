//
//  Router.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

class MoviesRouter: MoviesRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showDetail(movie: Movie?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(movie: movie, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
}
