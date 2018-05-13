//
//  UserListTableViewCell.swift
//  ECaFT
//
//  Created by Jannie on 4/18/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit
import SnapKit

class UserListTableViewCell: UITableViewCell {
    
    var companyName: UILabel!
    var booth: UILabel!
    var selectButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        companyName = UILabel()
        booth = UILabel()
        selectButton = UIButton()
        
        companyName.translatesAutoresizingMaskIntoConstraints = false
        booth.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        companyName.font = UIFont(name: "Avenir-Medium", size: 27)
        booth.font = UIFont(name: "Avenir-Medium", size: 27)
        booth.textColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        
        //set it up for changing images when selected vs. not selected
        selectButton.setImage(#imageLiteral(resourceName: "checklistUnchecked"), for: .normal)
        
        contentView.addSubview(companyName)
        contentView.addSubview(booth)
        contentView.addSubview(selectButton)
    }
    
    override func updateConstraints() {
        //insert Snapkit constraints
        booth.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-16)
        }
        
        selectButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(16)
        }
        
        companyName.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(selectButton).offset(50)
        }
        
        super.updateConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
