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
    
    var presenter: DetailViewPresenterProtocol!
    var cellPresenter: CastCellPresenterProtocol!
    
    // MARK: - UI
    
    private var castCollectionView: UICollectionView?
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    private let watchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 189/255, green: 46/255, blue: 63/255, alpha: 1)
        button.setTitle("Watch Now", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.lightGray, for: .disabled)
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
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        makeContstraints()
        addTargets()
        presenter.setData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _ = setupGradient
    }
    
    // MARK: - UI
    
    private func createUI() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailsLabel)
        view.addSubview(ratingLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(watchButton)
        view.addSubview(backButton)
        view.addSubview(bookmarkButton)
        
        castCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        guard let castCollectionView = castCollectionView else { return }
        castCollectionView.isScrollEnabled = false
        castCollectionView.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        castCollectionView.register(CastHeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "castHeaderView")
        castCollectionView.dataSource = self
        castCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(castCollectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 2, leading: 1, bottom: 0, trailing: 1)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
            header.pinToVisibleBounds = true
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .paging
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
    
    private func makeContstraints() {
        guard let castCollectionView = castCollectionView else { return }
        
        posterImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).inset(130)
            make.left.right.equalToSuperview().inset(20)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(ratingLabel).dividedBy(2)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview().dividedBy(4)
        }
        
        castCollectionView.snp.makeConstraints({ make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(watchButton.snp.height).multipliedBy(2.8)
        })
        
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(castCollectionView.snp.bottom).offset(5)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(watchButton.snp.width).dividedBy(4)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(30.0)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(30)
        }
    }
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Routing
    
    @objc private func backButtonTapped() {
        presenter.backToHome()
    }
    
    @objc private func watchButtonTapped() {
        presenter.showMovie()
    }
    
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    func setData(posterUrl: URL?, title: String, rating: String, description: String?) {
        posterImageView.kf.setImage(with: posterUrl)
        titleLabel.text = title
        ratingLabel.text = rating
        descriptionLabel.text = description
    }
    
    func setDetails(_ details: String) {
        detailsLabel.text = details
    }
    
    func updateCast() {
        castCollectionView?.reloadData()
    }
    
    func disableWatchButton() {
        watchButton.isEnabled = false
    }
    
}
