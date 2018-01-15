//
//  UIColor+Shared.swift
//  ECaFT
//
//  Created by Logan Allen on 11/25/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static let ecaftRed = UIColor.colorFromCode(code: 0xA81414)
    public static let ecaftDarkRed = UIColor.colorFromCode(code: 0x891010)
    public static let ecaftGold = UIColor.colorFromCode(code: 0xF7D62F)
    public static let ecaftGray = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
    public static let ecaftDarkGray = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    public static let ecaftLightGray = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
    public static let backgroundGray = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)

    public static func colorFromCode(code: Int) -> UIColor {
        let red = CGFloat((code & 0xFF0000) >> 16) / 255
        let green = CGFloat((code & 0xFF00) >> 8) / 255
        let blue = CGFloat(code & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
