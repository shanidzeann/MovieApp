//
//  TabBar.swift
//  MovieApp
//
//  Created by Anna Shanidze on 21.02.2022.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColors()
    }
    
    private func setColors() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        tabBar.backgroundColor = UIColor(red: 189/255, green: 46/255, blue: 63/255, alpha: 1)
        tabBar.tintColor = .white
    }
    
}
