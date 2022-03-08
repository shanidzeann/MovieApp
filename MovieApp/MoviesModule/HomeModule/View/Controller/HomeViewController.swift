//
//  ViewController.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    var presenter: HomeViewPresenterProtocol!
    var cellPresenter: MovieCellPresenterProtocol!
    var headerPresenter: HomeHeaderPresenterProtocol!
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "magnifyingglass")
        button.configuration = config
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupConstraints()
        presenter.setMovies()
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(100)
        }
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")
        collectionView?.register(HomeHeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerView")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            var groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(300))
            
            guard let view = self?.view.frame else { return nil }
            switch sectionKind {
            case .popular:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.width/2.6), heightDimension: .absolute(view.width * 0.58))
            case .topRated, .upcoming:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(view.width/2.9), heightDimension: .absolute(view.width * 0.52))
            }
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 20, bottom: 20, trailing: 20)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
    
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func setMovies() {
        createCollectionView()
    }
}
