//
//  TabViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        makeViewControllers()
        // UI changes
        self.tabBar.tintColor = UIColor.ecaftRed // Icon color of Active tab
        self.tabBar.unselectedItemTintColor = UIColor.ecaftDarkGray // Icon color of Inactive tab
        // Change tab bar text color
        let unselectedItem = [NSAttributedStringKey.foregroundColor: UIColor.ecaftDarkGray]
        let selectedItem = [NSAttributedStringKey.foregroundColor: UIColor.ecaftRed]
        for viewController in self.viewControllers! {
            viewController.tabBarItem.setTitleTextAttributes(unselectedItem, for: .normal)
            viewController.tabBarItem.setTitleTextAttributes(selectedItem, for: .selected)
            self.edgesForExtendedLayout = []
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func makeViewControllers() {
        let companyViewModel = CompanyViewModel()
        let filterViewModel = FilterViewModel()
        let listViewModel = ListViewModel()
        
        let homeVC = HomeViewController()
        let homeBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "tabHome"), selectedImage: #imageLiteral(resourceName: "tabHome"))
        homeVC.tabBarItem = homeBarItem
        
        let mapVC = MapViewController()
        let mapBarItem = UITabBarItem(title: "Map", image: #imageLiteral(resourceName: "tabMap"), selectedImage: #imageLiteral(resourceName: "tabMap"))
        mapVC.tabBarItem = mapBarItem
        
        let companyVC = CompanyViewController()
        companyVC.companyViewModel = companyViewModel
        companyVC.filterViewModel = filterViewModel
        companyVC.listViewModel = listViewModel
        let companyBarItem = UITabBarItem(title: "Companies", image: #imageLiteral(resourceName: "tabCompanies"), selectedImage: #imageLiteral(resourceName: "tabCompanies"))
        companyVC.tabBarItem = companyBarItem
        
        
        let controllers = [homeVC, mapVC, companyVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
        
    }
}
