//
//  HeaderSupplementaryView.swift
//  MovieApp
//
//  Created by Anna Shanidze on 22.02.2022.
//

import UIKit
import SnapKit

class HeaderSupplementaryView: UICollectionReusableView {
        
    private let label: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
    }
    
}
