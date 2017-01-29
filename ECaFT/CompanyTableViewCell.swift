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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    var btnIsFilled = false
    
    static let identifier = "CompanyTableViewCell"

    var name: String? {
        didSet {
            nameLabel.text = name //Sets text of name label to cell's name property
        }
    }
    
    var location: String? {
        didSet {
            locationLabel.text = "Booth " + location!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companyImage.contentMode = .scaleAspectFit

        //Set favorites button
        favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        favoritesButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


