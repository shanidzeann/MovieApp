//
//  Router.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

class MoviesRouter: MoviesRouterProtocol {
    var viewController: UIViewController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(viewController: UIViewController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.viewController = viewController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showDetail(movie: Movie?) {
        guard let detailViewController = assemblyBuilder?.createDetailModule(movie: movie, router: self) else { return }
        detailViewController.modalPresentationStyle = .fullScreen
        viewController?.present(detailViewController, animated: true)
    }
    
    func backToHome(from viewController: DetailViewProtocol?) {
        if viewController is DetailViewController {
            (viewController as? DetailViewController)?.dismiss(animated: true, completion: nil)
        }
    }
    
}
