//
//  FavoritesTableViewCell.swift
//  ECaFT
//
//  Created by Emily Lien on 1/28/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        companyLabel.frame = CGRect(x: companyLabel.frame.origin.x, y: companyLabel.frame.origin.y, width: companyLabel.frame.size.width - 50, height: companyLabel.frame.size.height)
    }
}
