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
        setCornerRadius()
    }
    
    private func setColors() {
        view.backgroundColor = UIColor(red: 29/255, green: 24/255, blue: 36/255, alpha: 1)
        tabBar.backgroundColor = UIColor(red: 189/255, green: 46/255, blue: 63/255, alpha: 1)
        tabBar.tintColor = .white
    }
    
    private func setCornerRadius() {
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 30
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = CGRect(x: tabBar.frame.origin.x + 15,
                              y: tabBar.frame.origin.y - 30,
                              width: tabBar.frame.size.width - 30,
                              height: tabBar.frame.size.height + 10)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            let buttons = tabBar.subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
            buttons.forEach {
                if let superviewHeight = $0.superview?.frame.height {
                    $0.center = CGPoint(x: $0.frame.midX, y: superviewHeight/2 - 5)
                }
            }
        }
    
}
