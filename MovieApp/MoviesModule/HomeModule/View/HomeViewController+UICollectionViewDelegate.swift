//
//  HomeViewController+UICollectionViewDelegate.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCollectionViewCell else { return }
        cell.movieImageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = presenter.lists?[indexPath.section].results else { return }
        let movie = movies[indexPath.item]
        
        presenter.tapOnMovie(movie: movie)
    }
}
