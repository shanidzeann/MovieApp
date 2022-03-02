//
//  HeaderSupplementaryView.swift
//  MovieApp
//
//  Created by Anna Shanidze on 22.02.2022.
//

import UIKit
import SnapKit

class HomeHeaderSupplementaryView: UICollectionReusableView {
    
    // MARK: - Properties
        
    private var presenter: HomeHeaderPresenterProtocol!
    
    // MARK: - UI
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .white
        return label
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
    
    func inject(presenter: HomeHeaderPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with urlString: String) {
        presenter.setTitle(for: urlString)
    }

    func createUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
    }
    
}


// MARK: - HomeHeaderProtocol

extension HomeHeaderSupplementaryView: HomeHeaderProtocol {
    func setTitle(_ title: String) {
        label.text = title
    }
}
