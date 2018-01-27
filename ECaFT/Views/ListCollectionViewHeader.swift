//
//  ListCollectionViewHeader.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

protocol ListCollectionViewDelegate {
    func didPressListAddBtn(button: UIButton)
}

class ListCollectionViewHeader: UICollectionReusableView {
    let screenSize: CGRect = UIScreen.main.bounds
    static let identifier = "ListCollectionViewHeader"
    var titleLabel = UILabel()
    var plusBtn = UIButton()
    var delegate: ListCollectionViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.ecaftLightGray3
        makeTitle()
        makePlusBtn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTitle() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: screenSize.width - plusBtn.frame.width, height: 37)
        titleLabel.text = "Lists"
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 20)
        titleLabel.textColor = UIColor.ecaftBlack2
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        self.addSubview(titleLabel)
        
        // Constraints
        let marginGuide = self.layoutMarginsGuide
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    }
    
    private func makePlusBtn() {
        plusBtn.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
        plusBtn.frame = CGRect(x: titleLabel.frame.width, y: 0, width: 28, height: 28)
        plusBtn.addTarget(self, action: #selector(listAddBtnPress(_ :)), for: .touchUpInside)
        self.addSubview(plusBtn)
        
        // Constraints
        let marginGuide = self.layoutMarginsGuide
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
        plusBtn.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        plusBtn.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        plusBtn.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    
    @objc func listAddBtnPress(_ button: UIButton) {
        delegate.didPressListAddBtn(button: button)
    }
}

