//
//  HomeViewController.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let screenSize : CGRect = UIScreen.main.bounds
    var careerFairTitle = UILabel()
    var bodyParagraph = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        let navBarHeight = tabBarItem.accessibilityFrame.height
        let backgroundHeight = view.frame.height - navBarHeight
        let backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: navBarHeight), size: CGSize(width: view.frame.width, height: backgroundHeight)))

        print("homeviewController")
        backgroundImageView.image = #imageLiteral(resourceName: "ecaftBackground")
        makeTitle()
        makeBodyParagraph()
        
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Home"
    }
    
    func makeTitle() {
        careerFairTitle = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.8, height: 30))
        careerFairTitle.center.x = 0.5*screenSize.width
        if(screenSize.height < 667.0) { //For iPhone 5s & below
            careerFairTitle.center.y = 70
        } else {
            careerFairTitle.center.y = 130
        }
        careerFairTitle.textAlignment = NSTextAlignment.center
        careerFairTitle.font = UIFont.boldSystemFont(ofSize: 20)
        careerFairTitle.textColor = UIColor.white
        careerFairTitle.text = "Welcome to the \n2017 Cornell Spring Technical & Entreprenurial Career Fair!"
        
        //Make title go onto other lines
        careerFairTitle.numberOfLines = 0 //set num of lines to infinity
        careerFairTitle.lineBreakMode = .byWordWrapping
        careerFairTitle.sizeToFit()
        view.addSubview(careerFairTitle)
    }
    
    func makeBodyParagraph() {
        bodyParagraph = UITextView(frame: CGRect(x: 0, y: 0, width: screenSize.width*0.8, height: 400))
        bodyParagraph.center.x = 0.5*screenSize.width
        if(screenSize.height < 667.0) { //For iPhone 5s & below
            bodyParagraph.center.y = 360
        } else {
            bodyParagraph.center.y = 400
        }
        
        bodyParagraph.textAlignment = NSTextAlignment.center
        bodyParagraph.font = UIFont.systemFont(ofSize: 15)
        bodyParagraph.textColor = UIColor.white
        bodyParagraph.backgroundColor = UIColor.clear
        bodyParagraph.isScrollEnabled = false
        bodyParagraph.isSelectable = false
        bodyParagraph.text = "The fair is at Barton Hall on Wednesday, February 8th and runs from 9:00am to 2:00pm. We recommend dressing up in formal attire and having multiple copies of your resume and a notepad to keep track of recruiter info. Remember to do your research before-hand and learn more about each company's open positions to show that you're prepared. Good luck!"
        view.addSubview(bodyParagraph)
    }
    
}
