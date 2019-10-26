//
//  CompanyTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/8/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit

protocol AddRemoveDelegate {
    func unstar(company: Company)
    func star(company: Company)
}

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var companyBack: UIImageView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var companyForThisCell: Company!
    var delegate: AddRemoveDelegate?
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
    var img: UIImage? {
        didSet {
            favoritesButton.setImage(img, for: .normal)
        }
    }
    
    @IBAction func starPressed(_ sender: UIButton) {
        if companyForThisCell.isFavorite {
            companyForThisCell.isFavorite = false
            favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
            delegate?.unstar(company: companyForThisCell)
            
        } else {
            companyForThisCell.isFavorite = true
            favoritesButton.setImage(#imageLiteral(resourceName: "favoritesFilled"), for: .normal)
            delegate?.star(company: companyForThisCell)
        }
        print(companyForThisCell.isFavorite)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companyImage.contentMode = .scaleAspectFit
        
        //Set favorites button
//        favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
//        favoritesButton.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


