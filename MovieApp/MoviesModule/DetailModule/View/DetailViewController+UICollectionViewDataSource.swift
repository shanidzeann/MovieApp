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
        return presenter?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CastCollectionViewCell
        
        let cast = presenter?.cast?[indexPath.item]
        if let profile = cast?.profilePath, let presenter = presenter {
            let url = URL(string: presenter.imageURL + profile)
            cell.actorImageView.kf.setImage(with: url)
        } else {
            cell.actorImageView.image = UIImage(systemName: "questionmark.circle")
        }
        cell.nameLabel.text = cast?.name
        cell.characterLabel.text = cast?.character
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "castHeaderView", for: indexPath) as? CastHeaderSupplementaryView else { return UICollectionReusableView() }
        return headerView
    }
    
}
