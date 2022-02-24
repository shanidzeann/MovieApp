//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by Anna Shanidze on 24.02.2022.
//

import UIKit
import SnapKit

class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI
    
    let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.backgroundColor = .red
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.font = .boldSystemFont(ofSize: 13)
        label.backgroundColor = .yellow
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Methods
    
    func createUI() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        
        actorImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImageView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(5.5)
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
}
