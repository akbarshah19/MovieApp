//
//  ViewController.swift
//  MovieApp
//
//  Created by Akbarshah Jumanazarov on 5/13/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }

    private func setUpControllers() {
        let home = HomeViewController()
        let topPage = TopPageViewController()
        let profile = ProfileViewController()
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: topPage)
        let nav3 = UINavigationController(rootViewController: profile)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Top Page", image: UIImage(systemName: "list.number"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}

