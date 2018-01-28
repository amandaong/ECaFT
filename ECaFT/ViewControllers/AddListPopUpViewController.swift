//
//  AddListPopUpViewController.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/27/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit
import SnapKit

class AddListPopUpViewController: UIViewController {
    let screenSize : CGRect = UIScreen.main.bounds
    var popUpView: UIView = UIView()
    var cancelBtn: UIButton = UIButton()
    var addListBtn: UIButton = UIButton()
    
    var popUpTitle: UILabel = UILabel()
    var nameTextView: UITextView = UITextView() // Enter list name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayFaded
        makePopUpView()
        makePopUpTitle()
        makeListNameTextView()
        makeButtons()
    }

    @objc func cancelBtnTapped(_ sender: UIButton) {
        
    }
    
    @objc func addListBtnTapped(_ sender: UIButton) {
        
    }
    
    private func makePopUpView() {
        popUpView.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.65, height: screenSize.height*0.35)
        popUpView.center = CGPoint(x: 0.5*screenSize.width, y: 0.5*screenSize.height)
        popUpView.backgroundColor = UIColor.whiteFaded
        popUpView.layer.cornerRadius = 25
        popUpView.layer.shadowColor = UIColor.gray.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 0, height: 10)
        popUpView.layer.shadowOpacity = 0.9
        popUpView.layer.shadowRadius = 5
        self.view.addSubview(popUpView)
    }
    
    private func makePopUpTitle() {
        popUpTitle.text = "List Name"
        popUpTitle.textColor = UIColor.ecaftBlack2
        popUpTitle.font = UIFont(name: "Avenir-Medium", size: 18)
        popUpView.addSubview(popUpTitle)
        
        popUpTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(popUpView)
            make.top.equalTo(popUpView).offset(20)
        }
        
    }
    
    private func makeListNameTextView() {
        self.automaticallyAdjustsScrollViewInsets = false
        nameTextView.textAlignment = NSTextAlignment.left
        nameTextView.textColor = UIColor.ecaftBlack2
        nameTextView.backgroundColor = UIColor.white
        popUpView.addSubview(nameTextView)
        
        nameTextView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popUpView).offset(20)
            make.right.greaterThanOrEqualTo(popUpView).offset(20)
            make.top.equalTo(popUpTitle.snp.bottom).offset(10)
            make.width.lessThanOrEqualTo(popUpView.snp.width)
            make.height.equalTo(35)
            make.centerY.equalTo(popUpView)
        }
    }
    
    private func makeButtons() {
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(UIColor.ecaftRed, for: .normal)
        cancelBtn.layer.borderWidth = 3
        cancelBtn.layer.borderColor = UIColor.whiteFadedPlus.cgColor
//        cancelBtn.roundBtnCorners([.bottomLeft], radius: 25)
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped(_:)), for: .touchUpInside)
        popUpView.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popUpView)
            make.bottom.equalTo(popUpView)
            make.size.equalTo(CGSize(width: 0.5*popUpView.frame.width, height: 0.25*popUpView.frame.height))
        }
        
        addListBtn.setTitle("Add", for: .normal)
        addListBtn.setTitleColor(UIColor.ecaftRed, for: .normal)
        addListBtn.layer.borderWidth = 3
        addListBtn.layer.borderColor = UIColor.whiteFadedPlus.cgColor
        //        cancelBtn.roundBtnCorners(.bottomLeft, radius: 8)
        addListBtn.addTarget(self, action: #selector(addListBtnTapped(_:)), for: .touchUpInside)
        popUpView.addSubview(addListBtn)
        
        addListBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(popUpView)
            make.bottom.equalTo(popUpView)
            make.size.equalTo(CGSize(width: 0.5*popUpView.frame.width, height: 0.25*popUpView.frame.height))
        }
    }
}
