//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var presenter: MovieCellPresenterProtocol!
    
    // MARK: - UI
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
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
    
    func inject(presenter: MovieCellPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(movie: Movie) {
        presenter.configure(movie: movie)
    }
    
    func createUI() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(indicatorView)
        
        movieImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.center.equalTo(movieImageView)
        }
    }
    
    override func prepareForReuse() {
        movieImageView.kf.cancelDownloadTask()
        movieImageView.kf.setImage(with: URL(string: ""))
        movieImageView.image = nil
    }
    
}


// MARK: -  MovieCellProtocol

extension MovieCollectionViewCell: MovieCellProtocol {
    func setData(title: String, releaseDate: String, imageURL: URL?) {
        indicatorView.startAnimating()
        titleLabel.text = title
        dateLabel.text = releaseDate
        movieImageView.kf.setImage(with: imageURL) { [weak self] _ in
            self?.indicatorView.stopAnimating()
        }
    }
}
