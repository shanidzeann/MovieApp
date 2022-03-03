//
//  TabBarRouterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol TabBarRouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    var tabBar: UITabBarController? { get set }
    func setupVCs()
}
