//
//  ViewController.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit
import Kingfisher

enum Section: Int, CaseIterable {
    case popular
    case topRated
    case upcoming
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    var presenter: HomeViewPresenterProtocol!
    var cellPresenter: MovieCellPresenterProtocol!
    var headerPresenter: HomeHeaderPresenterProtocol!
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        presenter.setMovies()
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.standardAppearance.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let label = UILabel()
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        navigationItem.titleView = label

        
        #warning("сдвигается после перехода")
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(100)
        }
        
        let button = UIButton(configuration: .plain(), primaryAction: nil)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "magnifyingglass")
        button.configuration = config
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            var groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(300))
            
            switch sectionKind {
            case .popular:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(250))
            case .topRated, .upcoming:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(200))
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
    
    private func createGradient() {
        let view = UIView(frame: CGRect(x: 0, y: view.bounds.maxY - 100, width: view.bounds.width, height: 100))
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [CGColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 0), CGColor(red: 0, green: 0, blue: 0, alpha: 0.7) ]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        self.view.addSubview(view)
        self.view.bringSubviewToFront(view)
    }
    
    override func viewDidLayoutSubviews() {
        createGradient()
    }
    
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func setMovies() {
        createCollectionView()
    }
}
