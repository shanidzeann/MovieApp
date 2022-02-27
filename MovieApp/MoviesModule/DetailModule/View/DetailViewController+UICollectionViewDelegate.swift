//
//  DetailViewController+UICollectionViewDelegate.swift
//  MovieApp
//
//  Created by Anna Shanidze on 27.02.2022.
//

import Foundation
import UIKit


extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CastCollectionViewCell else { return }
        cell.actorImageView.kf.cancelDownloadTask()
    }
}
