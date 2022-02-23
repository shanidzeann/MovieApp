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

// TODO: - MVP
// TODO: - Diffable data source
// TODO: - Custom tab bar
// TODO: - Detail VC (cast)

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    private let networkManager = NetworkManager()
    private var lists: [List]?
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        getMovies()
    }
    
    // MARK: - Helper methods
    
    private func getMovies() {
        networkManager.downloadUrls { [weak self] result in
            switch result {
            case .success(let lists):
                self?.lists = lists
                DispatchQueue.main.async {
                    self?.createCollectionView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let label = UILabel()
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        navigationItem.titleView = label
        
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
        collectionView?.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "headerView")
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
    
}

    // MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists?[section].results.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return lists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        
        guard let movies = lists?[indexPath.section].results else { return UICollectionViewCell() }
        let movie = movies[indexPath.item]
        
        cell.titleLabel.text = movie.title
        cell.dateLabel.text = movie.releaseDate
        let image = movie.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
        cell.movieImageView.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as? HeaderSupplementaryView else { return UICollectionReusableView() }
        
        headerView.section = indexPath.section
        
        return headerView
    }
    
}

    // MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCollectionViewCell else { return }
        cell.movieImageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movies = lists?[indexPath.section].results else { return }
        let movie = movies[indexPath.item]
        let detailVC = DetailViewController()
        detailVC.movie = movie
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}
