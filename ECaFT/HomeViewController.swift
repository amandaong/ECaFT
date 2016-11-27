//
//  HomeViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
    
        
        let navBarHeight = tabBarItem.accessibilityFrame.height
        let backgroundHeight = view.frame.height - navBarHeight
        let backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: navBarHeight), size: CGSize(width: view.frame.width, height: backgroundHeight)))
        
        backgroundImageView.image = UIImage(named: "ecaftBackground.png")
        
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Home"
    }
    
}
