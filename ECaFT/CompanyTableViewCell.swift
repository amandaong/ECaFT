//
//  CompanyTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/8/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        print("favorites button pressed")
    }
    
}
