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
        label.numberOfLines = 0
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
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
        textView.showsVerticalScrollIndicator = false
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
        presenter.setData()
    }
    
    override func viewDidLayoutSubviews() {
        _ = setupGradient
    }
    
    // MARK: - UI
    
    private func createUI() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bookmarkButton)
        navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.isTranslucent = true
        
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailsLabel)
        view.addSubview(ratingLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(watchButton)
        
        castCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        castCollectionView?.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        castCollectionView?.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        castCollectionView?.register(CastHeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "castHeaderView")
        castCollectionView?.dataSource = self
        castCollectionView?.showsVerticalScrollIndicator = false
        
        guard let castCollectionView = castCollectionView else { return }
        view.addSubview(castCollectionView)
        
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
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(ratingLabel)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(descriptionTextView).dividedBy(7)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(castCollectionView).dividedBy(1.3)
        }
        
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(castCollectionView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        castCollectionView.snp.makeConstraints({ make in
            make.top.equalTo(descriptionTextView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        })
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
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
    
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    
    func setData(posterUrl: URL?, title: String, rating: String, description: String?) {
        posterImageView.kf.setImage(with: posterUrl)
        titleLabel.text = title
        ratingLabel.text = rating
        descriptionTextView.text = description
    }
    
    func setDetails(_ details: String) {
        detailsLabel.text = details
    }
    
    func updateCast() {
        castCollectionView?.reloadData()
    }
    
}
