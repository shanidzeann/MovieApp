//
//  Router.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


class TabBarRouter: TabBarRouterProtocol {
    
    var tabBar: UITabBarController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(tabBar: UITabBarController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.tabBar = tabBar
        self.assemblyBuilder = assemblyBuilder
    }
    
    func setupVCs() {
        tabBar?.viewControllers = [
            assemblyBuilder!.createHomeViewController(HomeViewController()),
            assemblyBuilder!.createProfileViewController()
        ]
    }
    
}


