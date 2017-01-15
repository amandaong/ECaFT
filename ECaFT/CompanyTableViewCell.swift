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
            locationLabel.text = location
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companyImage.contentMode = .scaleAspectFit

        //Set favorites button
        favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        favoritesButton.setTitle("", for: .normal)
    }

    func setUpImage(image: UIImage?) {
        //Set company image
        self.companyImage.image = image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        if (!btnIsFilled) {
            favoritesButton.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
            btnIsFilled = !btnIsFilled
        } else {
            favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
            btnIsFilled = !btnIsFilled
        }
    }
    
}


