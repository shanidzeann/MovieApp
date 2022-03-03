//
//  RouterProtocol.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

protocol MoviesRouterProtocol: RouterMain {
    func showDetail(movie: Movie?)
}
