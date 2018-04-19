//
//  TabViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import SlidingTabBar

class TabViewController: UITabBarController, SlidingTabBarDataSource, SlidingTabBarDelegate, UITabBarControllerDelegate {
    
    var tabBarView: SlidingTabBar!
    var fromIndex: Int!
    var toIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
        let homeBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "tabHome"), selectedImage: #imageLiteral(resourceName: "tabHome"))
        homeVC.tabBarItem = homeBarItem
        
        let mapVC = MapViewController()
        let mapBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "tabMap"), selectedImage: #imageLiteral(resourceName: "tabMap"))
        mapVC.tabBarItem = mapBarItem
        
        let companyVC = CompanyViewController()
        let companyBarItem = UITabBarItem(title: "Companies", image: #imageLiteral(resourceName: "tabCompanies"), selectedImage: #imageLiteral(resourceName: "tabCompanies"))
        companyVC.tabBarItem = companyBarItem
        
        let listVC = ListViewController()
        let listBarItem = UITabBarItem(title: "List", image: #imageLiteral(resourceName: "Plus"), selectedImage: #imageLiteral(resourceName: "Plus"))
        listVC.tabBarItem = listBarItem
 
        let controllers = [homeVC, mapVC, companyVC, listVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
        self.tabBar.isHidden = true
        selectedIndex = 0 // Shows page with this index when app first loads
        delegate = self
        makeTabBarView()
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

    // MARK: - Private functions
    
    private func makeTabBarView() {
        tabBarView = SlidingTabBar(frame: tabBar.frame, initialTabBarItemIndex: selectedIndex)
        tabBarView.tabBarBackgroundColor = UIColor.ecaftRed
        tabBarView.tabBarItemTintColor = UIColor.whiteFaded
        tabBarView.selectedTabBarItemTintColor = UIColor.white
        tabBarView.selectedTabBarItemColors = [UIColor.ecaftDarkRed, UIColor.ecaftDarkRed, UIColor.ecaftDarkRed, UIColor.ecaftDarkRed]
        tabBarView.slideAnimationDuration = 0.3
        tabBarView.datasource = self
        tabBarView.delegate = self
        tabBarView.setup()
    
        view.addSubview(tabBarView)
        view.bringSubview(toFront: tabBarView)
    }
}
