//
//  AssemblyModuleBuilder.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createHomeModule(router: RouterProtocol) -> UIViewController {
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
        let router = Router(navigationController: navController, assemblyBuilder: self)
        if rootViewController is HomeViewController {
            vc = createHomeModule(router: router)
        } else {
            vc = createHomeModule(router: router)
        }
        navController.viewControllers = [vc]
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        
        return navController
    }
    
    func createDetailModule(movie: Movie?, router: RouterProtocol) -> UIViewController {
        let networkManager = NetworkManager()
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, networkManager: networkManager, router: router, movie: movie)
        view.presenter = presenter
        view.hidesBottomBarWhenPushed = true
        return view
    }
    
    
}
