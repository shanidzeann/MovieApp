//
//  HomeViewController+UICollectionViewDataSource.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.movieCell, for: indexPath) as! MovieCollectionViewCell
        
        cellPresenter = MovieCellPresenter(view: cell)
        cell.inject(presenter: cellPresenter)
        
        if let movie = presenter.movie(for: indexPath) {
            cell.configure(movie: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.homeHeader, for: indexPath) as? HomeHeaderSupplementaryView else { return UICollectionReusableView() }
        
        headerPresenter = HomeHeaderPresenter(view: headerView)
        headerView.inject(presenter: headerPresenter)
        let urlString = presenter.urlFor(section: indexPath.section)
        headerView.configure(with: urlString)
        
        return headerView
    }
    
}
