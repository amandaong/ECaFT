//
//  HomeViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let screenSize : CGRect = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        view.backgroundColor = UIColor.black
    
        makeFairTitle()
        makeLocationTitle()
        makeBanner()
        makeBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func makeLocationTitle() {
        let locationTitle = UILabel(frame: CGRect(x: 0, y: 180, width: screenSize.width*0.72, height: 30))
        locationTitle.center.x = 0.5*screenSize.width
        if(screenSize.height < 667.0) { //For iPhone 5s & below
            locationTitle.center.y = 135
        }
        locationTitle.textAlignment = NSTextAlignment.center
        locationTitle.font = UIFont(name: "Avenir-Medium", size: 28.0)
        locationTitle.textColor = UIColor.white
        locationTitle.text = "Wednesday, Feb. 8th \n9:00 am - 2:00 pm \nBarton Hall"
        
        //Make title go onto other lines
        locationTitle.numberOfLines = 0 //set num of lines to infinity
        locationTitle.lineBreakMode = .byWordWrapping
        locationTitle.sizeToFit()
        view.addSubview(locationTitle)
    }
    
    private func makeFairTitle() {
        let fairBanner = UIImageView(frame: CGRect(x: 0, y: 15, width: screenSize.width*0.65, height: 75))
        fairBanner.image = #imageLiteral(resourceName: "FairBanner")
        fairBanner.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(fairBanner)
    }
    
    private func makeBanner() {
        let banner = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 125))
        banner.image = #imageLiteral(resourceName: "HomeBanner")
        banner.contentMode = UIViewContentMode.scaleAspectFit
        banner.center.y = screenSize.height*0.7
        banner.center.x = screenSize.width - (banner.frame.width/2.0) + 15
        view.addSubview(banner)
    }
    
    private func makeBackground() {
        let navBarHeight = tabBarItem.accessibilityFrame.height
        let backgroundHeight = view.frame.height - navBarHeight
        let backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: navBarHeight), size: CGSize(width: view.frame.width, height: backgroundHeight)))
        backgroundImageView.image = #imageLiteral(resourceName: "ecaftBackground")
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
    }
    
}
