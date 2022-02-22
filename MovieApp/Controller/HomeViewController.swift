//
//  ViewController.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit

enum Section: Int, CaseIterable {
    case popularMovie
    case tvShow
    case continueWatching
}

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCollectionView()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        let label = UILabel()
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        navigationItem.titleView = label
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(60)
        }
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")
        collectionView?.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerView")
        collectionView?.dataSource = self
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
            case .popularMovie:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(250))
            case .tvShow:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
            case .continueWatching:
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(200))
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


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? HeaderSupplementaryView else { return UICollectionReusableView() }
        
        return headerView
    }
    
}
