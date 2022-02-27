//
//  TabBar.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit

class TabBar: UITabBarController {

    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setColors()
        setupVCs()
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")!),
            //createNavController(for: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person.fill")!)
        ]
    }
    
    private func setColors() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        tabBar.backgroundColor = UIColor(red: 189/255, green: 46/255, blue: 63/255, alpha: 1)
        tabBar.tintColor = .white
    }
    
    private func createNavController(for rootViewController: UIViewController & HomeViewProtocol,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let presenter = HomePresenter(view: rootViewController, networkManager: self.networkManager)
        rootViewController.presenter = presenter
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        
        return navController
    }
}
