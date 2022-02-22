//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Anna Shanidze on 22.02.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "Здесь могла быть ваша реклама"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
    }
    
    func createUI() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }

}
