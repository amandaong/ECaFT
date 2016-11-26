//
//  TabViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor.ecaftRed
        tabBar.backgroundColor = UIColor.ecaftRed
        tabBar.tintColor = UIColor.black
        tabBar.unselectedItemTintColor = UIColor.white

        delegate = self
        
        let homeVC = HomeViewController()
        let homeBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeUnselected.png"), selectedImage: UIImage(named: "homeSelected.png"))
        homeVC.tabBarItem = homeBarItem
        
        let mapVC = MapViewController()
        let mapBarItem = UITabBarItem(title: "Map", image: UIImage(named: "mapUnselected.png"), selectedImage: UIImage(named: "mapUnselected.png"))
        mapVC.tabBarItem = mapBarItem
        
        let companyVC = CompanyViewController()
        let companyBarItem = UITabBarItem(title: "Companies", image: UIImage(named: "companyUnselected.png"), selectedImage: UIImage(named: "companySelected.png"))
        companyVC.tabBarItem = companyBarItem
        
        let favoritesVC = FavoritesViewController()
        let favoritesBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favoritesUnselected.png"), selectedImage: UIImage(named: "favoritesSelected.png"))
        favoritesVC.tabBarItem = favoritesBarItem
        
        viewControllers = [homeVC, mapVC, companyVC, favoritesVC]
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
