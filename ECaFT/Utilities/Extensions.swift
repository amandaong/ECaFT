//
//  Extensions.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    public static let ecaftRed = UIColor.colorFromCode(code: 0xA81414)
    public static let ecaftDarkRed = UIColor.colorFromCode(code: 0x891010)
    public static let ecaftGold = UIColor.colorFromCode(code: 0xF7D62F)
    public static let ecaftGray = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
    public static let ecaftDarkGray = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    public static let ecaftLightGray = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    public static let ecaftLightGray2 = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    public static let ecaftBlack = UIColor(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
    public static let ecaftBlackFaded = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5)
    
    public static let backgroundGray = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    public static let favoritesBorderGray = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
    
    public static func colorFromCode(code: Int) -> UIColor {
        let red = CGFloat((code & 0xFF0000) >> 16) / 255
        let green = CGFloat((code & 0xFF00) >> 8) / 255
        let blue = CGFloat(code & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

extension UIView {
    // Rotate an image by specified degrees (eg .pi/2)
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
    
}


