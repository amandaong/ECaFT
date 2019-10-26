//
//  AppDelegate.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import Firebase
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabVC: TabViewController!
    
    //Declares instance of information state controller
    var companyViewModel: CompanyViewModel!
    var filterViewModel: FilterViewModel!
    var listViewModel: ListViewModel!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() //Sets up firebase
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().barTintColor = UIColor.ecaftRed
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        
        tabVC = TabViewController()
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
        //Pass information state controller to company view controller & favorites view controller
        companyViewModel = CompanyViewModel()
        filterViewModel = FilterViewModel()
        listViewModel = ListViewModel()
        
        let navControllers = self.tabVC.viewControllers
        
        let companyNavVC = navControllers?[2] as! UINavigationController
        let companyVC = companyNavVC.viewControllers.first as! CompanyViewController
        companyVC.companyViewModel = companyViewModel
        companyVC.filterViewModel = filterViewModel
        companyVC.listViewModel = listViewModel
        
        let listNavVC = navControllers?[3] as! UINavigationController
        let listVC = listNavVC.viewControllers.first as! FavoritesListViewController
        listVC.companyViewModel = companyViewModel
        listVC.filterViewModel = filterViewModel
        listVC.listViewModel = listViewModel
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

}

