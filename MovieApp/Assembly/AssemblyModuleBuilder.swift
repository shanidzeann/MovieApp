//
//  AssemblyModuleBuilder.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createHomeModule(_ viewController: UIViewController & HomeViewProtocol, router: MoviesRouterProtocol) -> UIViewController {
        let networkManager = NetworkManager()
        let view = viewController
        let presenter = HomePresenter(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }

    func createHomeViewController(_ viewController: UIViewController & HomeViewProtocol) -> UIViewController {
        let navController = UINavigationController()
        let router = MoviesRouter(viewController: viewController, assemblyBuilder: self)
        let vc = createHomeModule(viewController, router: router)
        navController.viewControllers = [vc]
        navController.tabBarItem.title = "Home"
        navController.tabBarItem.image = UIImage(systemName: "house.fill")
        navController.navigationBar.prefersLargeTitles = false
        return navController
    }
    
    func createProfileViewController() -> UIViewController {
        let navController = UINavigationController()
        let router = ProfileRouter(navigationController: navController, assemblyBuilder: self)
        let vc = createProfileModule(router: router)
        navController.viewControllers = [vc]
        navController.tabBarItem.title = "Profile"
        navController.tabBarItem.image = UIImage(systemName: "person.fill")
        navController.navigationBar.prefersLargeTitles = false
        
        return navController
    }
    
    func createDetailModule(movie: Movie?, router: MoviesRouterProtocol) -> UIViewController {
        let networkManager = NetworkManager()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkManager: networkManager, router: router, movie: movie)
        view.presenter = presenter
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
