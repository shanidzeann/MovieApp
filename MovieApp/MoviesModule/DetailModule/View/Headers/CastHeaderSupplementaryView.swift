//
//  CastHeaderSupplementaryView.swift
//  MovieApp
//
//  Created by Anna Shanidze on 24.02.2022.
//

import UIKit
import SnapKit

class CastHeaderSupplementaryView: UICollectionReusableView {
        
    private let label: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 19)
        label.textColor = .white
        label.text = "Cast"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
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
