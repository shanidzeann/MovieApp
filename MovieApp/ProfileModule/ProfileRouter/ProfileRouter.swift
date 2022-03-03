//
//  ProfileRouter.swift
//  MovieApp
//
//  Created by Anna Shanidze on 03.03.2022.
//

import Foundation
import UIKit

class ProfileRouter: RouterMain {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
}
