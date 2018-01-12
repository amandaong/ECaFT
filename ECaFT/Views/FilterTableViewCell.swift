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
    @IBOutlet weak var checkBtn: UIButton!
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
           checkBtn.setImage(#imageLiteral(resourceName: "filterCheckmark"), for: .normal)
        } else {
            checkBtn.setImage(nil, for: .normal)
        }
    }
    
}
