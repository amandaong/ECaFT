//
//  TabViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit
import SlidingTabBar

class TabViewController: UITabBarController, SlidingTabBarDataSource, SlidingTabBarDelegate, UITabBarControllerDelegate {
    
    var tabBarView: SlidingTabBar!
    var fromIndex: Int!
    var toIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isHidden = true
        selectedIndex = 0
        delegate = self
        
        let homeVC = HomeViewController()
        let homeBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home.png"), selectedImage: UIImage(named: "homeSelected.png"))
        homeVC.tabBarItem = homeBarItem
        
        let mapVC = MapViewController()
        let mapBarItem = UITabBarItem(title: "Map", image: UIImage(named: "map.png"), selectedImage: UIImage(named: "mapSelected.png"))
        mapVC.tabBarItem = mapBarItem
        
        let companyVC = CompanyViewController()
        let companyBarItem = UITabBarItem(title: "Companies", image: UIImage(named: "company.png"), selectedImage: UIImage(named: "companySelected.png"))
        companyVC.tabBarItem = companyBarItem
        
        let favoritesVC = FavoritesViewController()
        let favoritesBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "favorites.png"), selectedImage: UIImage(named: "favoritesSelected.png"))
        favoritesVC.tabBarItem = favoritesBarItem
 
        viewControllers = [homeVC, mapVC, companyVC, favoritesVC]
        
        tabBarView = SlidingTabBar(frame: tabBar.frame, initialTabBarItemIndex: selectedIndex)
        tabBarView.tabBarBackgroundColor = UIColor.ecaftRed
        tabBarView.tabBarItemTintColor = UIColor.white
        tabBarView.selectedTabBarItemTintColor = UIColor.white
        tabBarView.selectedTabBarItemColors = [UIColor.ecaftDarkRed, UIColor.ecaftDarkRed, UIColor.ecaftDarkRed, UIColor.ecaftDarkRed]
        tabBarView.slideAnimationDuration = 0.3
        tabBarView.datasource = self
        tabBarView.delegate = self
        tabBarView.setup()
        
        tabBarView.frame.origin.y = view.frame.height - 113
        
        view.addSubview(tabBarView)
        view.bringSubview(toFront: tabBarView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    // MARK: - SlidingTabBarDataSource
    
    func tabBarItemsInSlidingTabBar(tabBarView: SlidingTabBar) -> [UITabBarItem] {
        return tabBar.items!
    }
    
    // MARK: - SlidingTabBarDelegate
    
    func didSelectViewController(tabBarView: SlidingTabBar, atIndex index: Int, from: Int) {
        fromIndex = from
        toIndex = index
        selectedIndex = index
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // use same duration as for tabBarView.slideAnimationDuration
        // you can choose direction in which view controllers should be changed:
        // - .Both(default),
        // - .Reverse,
        // - .Left,
        // - .Right
        return SlidingTabAnimatedTransitioning(transitionDuration: 0.3, direction: .Both,
                                               fromIndex: self.fromIndex, toIndex: self.toIndex)
    }

}
