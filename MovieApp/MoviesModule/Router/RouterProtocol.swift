//
//  RouterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol RouterProtocol: RouterMain {
    var navigationController: UINavigationController? { get set }
    func showDetail(movie: Movie?)
}
