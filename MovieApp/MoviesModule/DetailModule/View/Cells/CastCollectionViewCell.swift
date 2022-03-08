//
//  CastCollectionViewCell.swift
//  MovieApp
//
//  Created by Anna Shanidze on 24.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var presenter: CastCellPresenterProtocol!
    
    // MARK: - UI
    
    let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.font = .systemFont(ofSize: 9)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actorImageView.layer.cornerRadius = actorImageView.frame.width/2
    }
    
    // MARK: - Helper Methods
    
    func inject(presenter: CastCellPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with cast: Cast) {
        presenter.configure(with: cast)
    }
    
    
    func createUI() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        
        actorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2.5)
            make.width.equalTo(actorImageView.snp.height)
            make.centerX.equalToSuperview()
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
    
    override func prepareForReuse() {
        actorImageView.kf.cancelDownloadTask()
        actorImageView.kf.setImage(with: URL(string: ""))
        actorImageView.image = nil
    }
}

// MARK: -  CastCellProtocol

extension CastCollectionViewCell: CastCellProtocol {
    func setData(profileUrl: URL?, name: String, character: String?) {
        if let url = profileUrl {
            actorImageView.kf.setImage(with: url)
        } else {
            actorImageView.image = UIImage(systemName: "questionmark.circle")
        }
        nameLabel.text = name
        characterLabel.text = character
    }
}
