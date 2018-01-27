//
//  ListCollectionViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "ListCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.ecaftListRed.cgColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.ecaftLightGray3
        // Makes label multi-line
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.76 // = 13/17 = minimum font size/default font size of label
    }

}
