//
//  HomeViewController+UICollectionViewDelegate.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = presenter.movie(for: indexPath)
        presenter.tapOnMovie(movie: movie)
    }
}
