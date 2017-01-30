//
//  FavoritesTableViewCell.swift
//  ECaFT
//
//  Created by Emily Lien on 1/28/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    let screenSize : CGRect = UIScreen.main.bounds
    var favoritesButton = UIButton()
    var checkButton = UIButton()
    var companyImageView: UIImageView!
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    // @IBOutlet weak var checkButton: UIButton!
   // @IBOutlet weak var companyLabel: UILabel!

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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Name of company
        nameLabel = UILabel(frame: CGRect(x: 0.3*screenSize.width, y: 0, width: 0.57*screenSize.width, height: 30))
        nameLabel.center.y = 21
        nameLabel.textAlignment = .left
        nameLabel.text = "Accacia Communications"
        nameLabel.textColor = UIColor.black
        nameLabel.font = .systemFont(ofSize: 20)
        contentView.addSubview(nameLabel)
        
        //Location of company
        locationLabel = UILabel(frame: CGRect(x: 0.3*screenSize.width, y: 0, width: 0.75*screenSize.width, height: 30))
        locationLabel.center.y = 48
        locationLabel.textAlignment = .left
        locationLabel.text = "Booth A4-A5"
        locationLabel.textColor = UIColor.ecaftDarkGray
        locationLabel.font = .systemFont(ofSize: 17)
        contentView.addSubview(locationLabel)
        
        //Company image
        companyImageView  = UIImageView(frame: CGRect(x: 0.15*screenSize.width, y: 0, width: 45, height: 45))
        companyImageView.center.y = 35
        companyImageView.contentMode = .scaleAspectFit
        contentView.addSubview(companyImageView)
        
        //Create favorites button
        favoritesButton.frame = CGRect(x: 0.8*screenSize.width, y: 0, width: 0.25*screenSize.width, height: 30)
        favoritesButton.center.y = 35
        favoritesButton.setImage(#imageLiteral(resourceName: "favorites"), for: .normal)
        contentView.addSubview(favoritesButton)
        
        //Create check button
        checkButton.frame = CGRect(x: 0.03*screenSize.width, y: 0, width: 40, height: 40)
        checkButton.center.y = 35
        checkButton.setImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
        contentView.addSubview(checkButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
