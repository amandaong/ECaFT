//
//  FilterCollectionViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 11/27/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterBtn : UIButton!
    var exitBtn : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeButtons(){
        //Make exit button
        let image = UIImage(named: "exit.png") as UIImage?
        let exitBtn   = UIButton()
        exitBtn.frame = CGRect(x: 0, y: 0, width: frame.width*0.2, height: frame.height)
        exitBtn.setImage(image, for: UIControlState.normal)
        exitBtn.tag = 1
        exitBtn.addTarget(self, action: Selector(("filterOrExitBtnPressed:")), for:.touchUpInside)
        self.addSubview(exitBtn)
        
        //Make filter button
        let filterBtn = UIButton()
        filterBtn.frame = CGRect(x: exitBtn.frame.width-5, y: 0, width: frame.width-exitBtn.frame.width, height: frame.height)
        filterBtn.setTitle("Employment Type", for: UIControlState.normal)
        filterBtn.titleLabel?.font =  UIFont(name: "Avenir-Book", size: 14)
        filterBtn.tag = 2
        filterBtn.addTarget(self, action: Selector(("filterOrExitBtnPressed:")), for: UIControlEvents.touchUpInside)
        self.addSubview(filterBtn)
        
    }
    
    //Fix: THROWING NSEXCEPTION ERROR WHEN PRESS FILTER BUTTON IDK WHY
    func filterOrExitBtnPressed(sender: UIButton!) {
        if sender.tag == 1 { //exit btn pressed
            //do anything here
        }
        if sender.tag == 2 { //filter type btn pressed
            
        }
    }
}
