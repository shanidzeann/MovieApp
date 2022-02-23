//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Anna Shanidze on 23.02.2022.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            createUI()
            setData()
        }
    }
    
    // MARK: - UI
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = nil
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 17)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    private let watchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 189/255, green: 46/255, blue: 63/255, alpha: 1)
        button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
     private let backButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.backward")
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    
    private let bookmarkButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "bookmark")
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        _ = setupGradient
    }
    
    private func createUI() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailsLabel)
        view.addSubview(ratingLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(watchButton)
        view.addSubview(backButton)
        view.addSubview(bookmarkButton)
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(30)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(30)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).inset(130)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(detailsLabel).multipliedBy(3)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(ratingLabel).dividedBy(1.5)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(descriptionTextView).dividedBy(7)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
    }
    
    // MARK: - Helper Methods
    
    private func setData() {
        guard let movie = movie else { return }
        
        let image = movie.backdropPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
        posterImageView.kf.setImage(with: url)
        
        titleLabel.text = movie.title
        detailsLabel.text = movie.releaseDate
        ratingLabel.text = "\(movie.voteAverage)"
        descriptionTextView.text = movie.overview
    }
    
    @objc private func backToHome() {
        dismiss(animated: true)
    }
    
    private lazy var setupGradient: Void = {
        let view = UIView(frame: posterImageView.bounds)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clear.cgColor, self.view.backgroundColor?.cgColor ?? UIColor.clear.cgColor]
        gradient.locations = [0.5, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        posterImageView.addSubview(view)
        posterImageView.bringSubviewToFront(view)
    }()
    
}
