//
//  AddCompanyPopUpViewCell.swift
//  ECaFT
//
//  Created by Jannie on 1/30/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class AddCompanyPopUpViewCell: UITableViewCell {
    var listName: UILabel!
    var checkButton: UIButton!
    static let identifier = "AddCompanyPopUpViewCell"
    
    
    var listItem: ListItem? {
        didSet {
            if (listItem?.isSelected)! {
                checkButton.setImage(#imageLiteral(resourceName: "checklistChecked"), for: .normal)
            } else {
                checkButton.setImage(#imageLiteral(resourceName: "checklistUnchecked"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

