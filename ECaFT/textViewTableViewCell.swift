//
//  textViewTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 2/1/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class textViewTableViewCell: UITableViewCell {
    let screenSize : CGRect = UIScreen.main.bounds
    var bodyTextView = UITextView()
   
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        var horOffSet = 0.04*screenSize.width
        bodyTextView = UITextView(frame: CGRect(x: horOffSet, y: 0, width: 0.89*screenSize.width, height: 100))
        bodyTextView.backgroundColor = .blue
        bodyTextView.textAlignment = NSTextAlignment.left
        bodyTextView.font = UIFont.systemFont(ofSize: 15)
        bodyTextView.textColor = UIColor.black
        bodyTextView.backgroundColor = UIColor.clear
        bodyTextView.isScrollEnabled = false
        bodyTextView.isSelectable = false
        contentView.addSubview(bodyTextView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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
