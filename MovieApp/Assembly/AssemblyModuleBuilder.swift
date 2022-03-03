//
//  AssemblyModuleBuilder.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createHomeModule(router: MoviesRouterProtocol) -> UIViewController {
        let networkManager = NetworkManager()
        let view = HomeViewController()
        let presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createNavController(for rootViewController: UIViewController & ViewProtocol,
                             title: String,
                             image: UIImage) -> UIViewController {
        let vc: UIViewController
        let navController = UINavigationController()
        if rootViewController is HomeViewController {
            let router = MoviesRouter(navigationController: navController, assemblyBuilder: self)
            vc = createHomeModule(router: router)
        } else {
            let router = ProfileRouter(navigationController: navController, assemblyBuilder: self)
            vc = createProfileModule(router: router)
        }
        navController.viewControllers = [vc]
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        
        return navController
    }
    
    func createDetailModule(movie: Movie?, router: MoviesRouterProtocol) -> UIViewController {
        let networkManager = NetworkManager()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkManager: networkManager, router: router, movie: movie)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    func createProfileModule(router: RouterMain) -> UIViewController {
        let networkManager = NetworkManager()
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
}
