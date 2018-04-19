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
    public static let ecaftRedBright = UIColor(red: 200/255, green: 30/255, blue: 22/255, alpha: 1)
    public static let ecaftRedLight = UIColor(red: 179/255, green: 27/255, blue: 27/255, alpha: 1)
    public static let ecaftDarkRed = UIColor.colorFromCode(code: 0x891010)
    public static let ecaftListRed = UIColor(red: 168/255, green: 20/255, blue: 20/255, alpha: 1)
    public static let ecaftListBorderGray = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    public static let ecaftGold = UIColor.colorFromCode(code: 0xF7D62F)
    public static let ecaftGray = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
    public static let ecaftDarkGray = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    public static let ecaftLightGray = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    public static let ecaftLightGray2 = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    public static let ecaftLightGray3 = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    public static let ecaftBlack = UIColor(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
    public static let ecaftBlack2 = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
    public static let ecaftBlackFaded = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 0.5)
    
    public static let backgroundGray = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
    public static let popUpGray = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
    public static let favoritesBorderGray = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
    public static let whiteFaded = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.75)
    public static let whiteFadedPlus = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
    public static let grayFaded = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25)
    public static let blueDark = UIColor(red: 0/255, green: 55/255, blue: 55/255, alpha: 1.0)
    public static let turquoise = UIColor(red: 51/255, green: 137/255, blue: 137/255, alpha: 1.0)
    public static let listBackground = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1.0)
    
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
    
    // Rounds specificied corners of UIView
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIButton{
    // Round specified corners of button
    func roundBtnCorners(_ corners:UIRectCorner, radius: CGFloat)
    {
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.layer.bounds
        borderLayer.strokeColor = UIColor(red: 168/266, green: 20/255, blue: 20/255, alpha: 0.7).cgColor
//            GenerateShape.UIColorFromHex(0x989898, alpha: (1.0-0.3)).cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1.0
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        borderLayer.path = path.cgPath
        self.layer.addSublayer(borderLayer);
    }
}

extension CALayer {
    
    // Add border to specific side of shape (top, bottom, left, right)
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
}

extension UIImage {
    // For background color of Reset button
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}


