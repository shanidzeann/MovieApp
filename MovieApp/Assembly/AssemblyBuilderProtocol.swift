//
//  AssemblyBuilderProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createHomeModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(movie: Movie?, router: RouterProtocol) -> UIViewController
    func createNavController(for rootViewController: UIViewController & ViewProtocol,
                             title: String,
                             image: UIImage) -> UIViewController
}
