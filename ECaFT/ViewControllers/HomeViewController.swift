//
//  HomeViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let screenSize : CGRect = UIScreen.main.bounds
    var topBanner : UIImageView = UIImageView()
    var locationTitle : UILabel = UILabel()
    var backgroundImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.edgesForExtendedLayout = [] // View controller fits btwn top nav bar & bottom tab bar
        view.backgroundColor = UIColor.black
    
        makeFairTitle()
        makeLocationTitle()
        makeBackground()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func makeLocationTitle() {
        locationTitle = UILabel(frame: CGRect(x: 0, y: 180, width: screenSize.width*0.72, height: 30))
        locationTitle.center.x = 0.5*screenSize.width
        if(screenSize.height < 667.0) { //For iPhone 5s & below
            locationTitle.center.y = 135
        }
        locationTitle.textAlignment = NSTextAlignment.center
        locationTitle.font = UIFont(name: "Avenir-Medium", size: 25.0)
        locationTitle.textColor = UIColor.white
        locationTitle.text = "Wednesday, Feb. 8th \n9:00 am - 2:00 pm \nBarton Hall"
        
        //Make title go onto other lines
        locationTitle.numberOfLines = 0 //set num of lines to infinity
        locationTitle.lineBreakMode = .byWordWrapping
        locationTitle.sizeToFit()
        view.addSubview(locationTitle)
    }
    
    private func makeFairTitle() {
        topBanner = UIImageView(frame: CGRect(x: 0, y: 15, width: screenSize.width*0.65, height: 75))
        topBanner.image = #imageLiteral(resourceName: "FairBanner")
        topBanner.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(topBanner)
    }

    
    private func makeBackground() {
        let navBarHeight = tabBarItem.accessibilityFrame.height
        let backgroundHeight = view.frame.height - navBarHeight
        let viewHeight = getViewHeight()
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: viewHeight-10))
        backgroundImageView.image = #imageLiteral(resourceName: "ecaftBackground")
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
    }
    
    private func getViewHeight() -> CGFloat {
        let topHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        let bottomHeight = (tabBarController?.tabBar.frame.height != nil) ? tabBarController?.tabBar.frame.height : 0
        let viewHeight = UIScreen.main.bounds.height - topHeight - bottomHeight!
        return viewHeight
    }
    
    private func makeConstraints() {
        backgroundImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.width.equalTo(screenSize.width)
            make.height.equalTo(getViewHeight())
        }
        topBanner.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view).offset(15)
            make.left.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        locationTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.frame.width*0.5)
            make.centerY.equalTo(getViewHeight()*0.5)
        }
    }
    
}
