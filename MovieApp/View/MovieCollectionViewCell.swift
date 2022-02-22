//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
     let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
     let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 19)
        label.text = "Movie"
        return label
    }()
    
     let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        
        label.text = "june 22"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
        }
    }
    
}