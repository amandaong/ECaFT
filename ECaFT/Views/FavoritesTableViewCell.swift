//
//  FavoritesTableViewCell.swift
//  ECaFT
//
//  Created by Emily Lien on 1/28/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit

protocol ListTableViewDelegate {
    func didPressCheckButton(button: UIButton!)
}

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    static let identifier = "FavoritesTableViewCell"
    var delegate: ListTableViewDelegate!
    
    var listItem: ListItem? {
        didSet {
            companyLabel?.text = listItem?.companyName
            if (listItem?.isSelected)! {
                checkButton.setImage(#imageLiteral(resourceName: "checklistChecked"), for: .normal)
            } else {
                checkButton.setImage(#imageLiteral(resourceName: "checklistUnchecked"), for: .normal)
            }
            locationLabel?.text = listItem?.booth
        }
    }
    
    @objc func toggleCheck(_ button: UIButton) {
        delegate.didPressCheckButton(button: button)
    }

 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set cell location label text
        
        checkButton.addTarget(self, action: #selector(toggleCheck(_:)), for: .touchUpInside)
        
        //add border
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.favoritesBorderGray.cgColor
        
        contentView.backgroundColor = UIColor.listBackground
    }
}
