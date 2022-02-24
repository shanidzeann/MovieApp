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
        label.font = .boldSystemFont(ofSize: 12)
        label.backgroundColor = .red
        label.text = "Megan Fox"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.font = .systemFont(ofSize: 10)
        label.backgroundColor = .black
        label.textAlignment = .center
        label.text = "Telslslslsuzik"
        label.numberOfLines = 0
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
            make.height.equalToSuperview().dividedBy(2.3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(actorImageView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
    }
}
