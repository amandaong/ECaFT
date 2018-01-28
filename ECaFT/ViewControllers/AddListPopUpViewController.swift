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
    var cornerRadius: CGFloat = 25 // corner radius of pop up view & btns
    var popUpView: UIView = UIView()
    var cancelBtn: UIButton = UIButton()
    var addListBtn: UIButton = UIButton()
    
    var popUpTitle: UILabel = UILabel()
    var listNameTextField: UITextField = UITextField() // Enter list name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayFaded
        makePopUpView()
        makePopUpTitle()
        makeListNameTextField()
        makeButtons()
    }

    @objc func cancelBtnTapped(_ sender: UIButton) {
        
    }
    
    @objc func addListBtnTapped(_ sender: UIButton) {
        
    }
    
    private func makePopUpView() {
        popUpView.frame = CGRect(x: 0, y: 0, width: screenSize.width*0.65, height: screenSize.height*0.35)
        popUpView.center = CGPoint(x: 0.5*screenSize.width, y: 0.5*screenSize.height)
        popUpView.backgroundColor = UIColor.white
        popUpView.layer.cornerRadius = cornerRadius
        popUpView.layer.shadowColor = UIColor.gray.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 0, height: 10)
        popUpView.layer.shadowOpacity = 0.9
        popUpView.layer.shadowRadius = 5
        self.view.addSubview(popUpView)
    }
    
    private func makePopUpTitle() {
        popUpTitle.text = "List Name"
        popUpTitle.textColor = UIColor.black
        popUpTitle.font = UIFont(name: "Avenir-Heavy", size: 20)
        popUpView.addSubview(popUpTitle)
        
        popUpTitle.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(popUpView)
            make.top.equalTo(popUpView).offset(20)
        }
        
    }
    
    private func makeListNameTextField() {
        self.automaticallyAdjustsScrollViewInsets = false
        listNameTextField.textAlignment = NSTextAlignment.left
        listNameTextField.textColor = UIColor.ecaftBlack2
        listNameTextField.backgroundColor = UIColor.backgroundGray
        listNameTextField.placeholder = "Enter the name of your list here"
        listNameTextField.autocorrectionType = UITextAutocorrectionType.no
        listNameTextField.keyboardType = UIKeyboardType.default
        listNameTextField.returnKeyType = UIReturnKeyType.done
        listNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        listNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        listNameTextField.delegate = self
        popUpView.addSubview(listNameTextField)
        
        listNameTextField.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popUpView).offset(20)
            make.right.lessThanOrEqualTo(popUpView).offset(-20).priority(.required)
            make.top.equalTo(popUpTitle.snp.bottom).offset(-10)
            make.width.lessThanOrEqualTo(popUpView.snp.width)
            make.height.equalTo(35)
            make.centerY.equalTo(popUpView)
        }
    }
    
    private func makeButtons() {
        cancelBtn = makePopUpBtn(title: "Cancel", roundedCorners: [.bottomLeft])
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped(_:)), for: .touchUpInside)
        popUpView.addSubview(cancelBtn)
        
        cancelBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(popUpView)
            make.bottom.equalTo(popUpView)
            make.size.equalTo(CGSize(width: 0.5*popUpView.frame.width, height: 0.25*popUpView.frame.height))
        }
        
        addListBtn = makePopUpBtn(title: "Add", roundedCorners: [.bottomRight])
        addListBtn.addTarget(self, action: #selector(addListBtnTapped(_:)), for: .touchUpInside)
        popUpView.addSubview(addListBtn)
        
        addListBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(popUpView)
            make.bottom.equalTo(popUpView)
            make.size.equalTo(CGSize(width: 0.5*popUpView.frame.width, height: 0.25*popUpView.frame.height))
        }
    }
    
    private func makePopUpBtn(title: String, roundedCorners: UIRectCorner ) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.ecaftListRed, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Avenir-Medium", size: 20)
        button.frame = CGRect(x: 0, y: 0, width: 0.5*popUpView.frame.width, height: 0.25*popUpView.frame.height)
        button.layer.borderColor = UIColor.ecaftListRed.cgColor
        button.roundBtnCorners(roundedCorners, radius: cornerRadius)
        return button
    }
}

extension AddListPopUpViewController: UITextFieldDelegate {
    
}
