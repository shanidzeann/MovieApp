//
//  Router.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

class MoviesRouter: MoviesRouterProtocol {
    var viewController: HomeViewProtocol?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(viewController: HomeViewProtocol, assemblyBuilder: AssemblyBuilderProtocol) {
        self.viewController = viewController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showDetail(movie: Movie?) {
        guard let detailViewController = assemblyBuilder?.createDetailModule(movie: movie, router: self) else { return }
        detailViewController.modalPresentationStyle = .fullScreen
        (viewController as? HomeViewController)?.present(detailViewController, animated: true)
    }
    
    func backToHome(from viewController: DetailViewProtocol?) {
        if viewController is DetailViewController {
            (viewController as? DetailViewController)?.dismiss(animated: true, completion: nil)
        }
    }
    
    func openInSafari(url: URL) {
        UIApplication.shared.open(url)
    }
    
}
