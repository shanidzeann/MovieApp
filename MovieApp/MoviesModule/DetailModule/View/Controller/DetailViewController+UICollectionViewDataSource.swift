//
//  DetailViewController+UICollectionViewDataSource.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionView.CellIdentifiers.castCell, for: indexPath) as! CastCollectionViewCell
        
        cellPresenter = CastCellPresenter(view: cell)
        cell.inject(presenter: cellPresenter)
        
        if let cast = presenter.cast(for: indexPath) {
            cell.configure(with: cast)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.CollectionView.Headers.castHeader, for: indexPath) as? CastHeaderSupplementaryView else { return UICollectionReusableView() }
        return headerView
    }
    
}
