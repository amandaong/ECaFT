//
//  ButtonSpacing.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/9/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit

/* For Button with image and text on the side:
 Adds spacing around button's image & text so they're evenly spaced out*/
 
extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
