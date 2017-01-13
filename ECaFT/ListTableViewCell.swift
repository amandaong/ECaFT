//
//  ListTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/7/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
