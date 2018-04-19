//
//  UserListCollectionViewCell.swift
//  ECaFT
//
//  Created by Jannie on 4/18/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

class UserListCollectionViewCell: UICollectionViewCell {
    
    var listName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        listName = UILabel()
        
        contentView.addSubview(listName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Update constraints
    override func updateConstraints() {
        listName.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        super.updateConstraints()
    }
    
}
