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
    
    let networkManager = NetworkManager()
    let imageURL = "https://image.tmdb.org/t/p/w500"
    
    var movie: Movie?
    var cast: [Cast]?
    var details: Details?
    
    // MARK: - UI
    
    private var castCollectionView: UICollectionView!
    
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
        setData()
    }
    
    override func viewDidLayoutSubviews() {
        _ = setupGradient
    }
    
    // MARK: - UI
    
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
        
        castCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        castCollectionView.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        castCollectionView?.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        castCollectionView?.register(CastHeaderSupplementaryView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "castHeaderView")
        castCollectionView?.dataSource = self
        castCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(castCollectionView ?? UICollectionView())
        
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
        
        backButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
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
    
    // MARK: - Helper Methods
    
    private func setData() {
        guard let movie = movie else { return }
        getCast(from: movie.id) {
            DispatchQueue.main.async { [weak self] in
                self?.castCollectionView.reloadData()
            }
        }
        
        getDetails(from: movie.id) {
            DispatchQueue.main.async { [weak self] in
                self?.setDetails()
            }
        }
        
        let image = movie.backdropPath
        let url = URL(string: imageURL + image)
        posterImageView.kf.setImage(with: url)
        
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.voteAverage)"
        descriptionTextView.text = movie.overview
    }
    
    private func setDetails() {
        guard let details = details else { return }

        let releaseDate = details.releaseDate.prefix(4)
       
        let interval = details.runtime * 60
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        guard let runtime = formatter.string(from: TimeInterval(interval)) else { return }
        
        var allGenres = ""
        for genre in details.genres {
            allGenres.append(genre.name)
            if genre.name != details.genres.last?.name {
                allGenres += ", "
            }
        }
        
        detailsLabel.text = releaseDate + " · " + allGenres + " · " + runtime
    }
    
    private func getCast(from movieId: Int, completion: @escaping () -> Void) {
        cast = nil
        networkManager.downloadCast(id: movieId) { [weak self] result in
            switch result {
            case .success(let cast):
                self?.cast = cast
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getDetails(from movieId: Int, completion: @escaping () -> Void) {
        details = nil
        networkManager.downloadDetails(id: movieId) { [weak self] result in
            switch result {
            case .success(let details):
                self?.details = details
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func backToHome() {
        dismiss(animated: true)
    }
    
}


// MARK: - UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CastCollectionViewCell
        
        let cast = cast?[indexPath.item]
        if let profile = cast?.profilePath {
            let url = URL(string: imageURL + profile)
            cell.actorImageView.kf.setImage(with: url)
        } else {
            cell.actorImageView.image = UIImage(systemName: "questionmark.circle")
        }
        cell.nameLabel.text = cast?.name
        cell.characterLabel.text = cast?.character
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "castHeaderView", for: indexPath) as? CastHeaderSupplementaryView else { return UICollectionReusableView() }
        return headerView
    }
    
}

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CastCollectionViewCell else { return }
        cell.actorImageView.kf.cancelDownloadTask()
    }
}
