//
//  FilterTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var checkBtnImageView: UIImageView!
    static let identifier = "FilterTableViewCell"
    
    var item: FilterOptionItem? {
        didSet {
            titleLabel?.text = item?.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Prevents cell from turning grey when selected
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}
