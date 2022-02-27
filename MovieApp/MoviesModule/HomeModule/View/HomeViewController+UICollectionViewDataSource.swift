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
        return presenter.lists?[section].results.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.lists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        guard let movies = presenter.lists?[indexPath.section].results else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        cell.titleLabel.text = movie.title
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatterGet.date(from: movie.releaseDate) {
            cell.dateLabel.text = dateFormatterPrint.string(from: date)
        }
        
        let image = movie.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
        cell.movieImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? HomeHeaderSupplementaryView else { return UICollectionReusableView() }
        
        headerView.section = indexPath.section
        
        return headerView
    }
    
}
