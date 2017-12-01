//
//  CompanyInfoTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/7/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit

class CompanyInfoTableViewCell: UITableViewCell {
    let screenSize : CGRect = UIScreen.main.bounds
    var informationTextView: UITextView!
    var websiteButton = UIButton()
    
    var information: String? {
        didSet {
            informationTextView.text = information //Sets text of name label to cell's name property
        }
    }
    var websiteLink: String?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Hor offset
        let horOffSet = 0.05*screenSize.width
        
        //Create industry label
        informationTextView = UITextView(frame: CGRect(x: horOffSet, y: 0, width: 0.9*screenSize.width, height: 135))
        informationTextView.center.y = 80
        informationTextView.textAlignment = .left
        informationTextView.textColor = UIColor.ecaftDarkGray
        informationTextView.font = .systemFont(ofSize: 15)
        
        //Disables editing text view
        informationTextView.isEditable = false
        informationTextView.isSelectable = false
        
        //Removes padding from text view
        let padding = informationTextView.textContainer.lineFragmentPadding
        informationTextView.textContainerInset = UIEdgeInsetsMake(0, -padding, 0, -padding)
        contentView.addSubview(informationTextView)

        //Create website button
        websiteButton.setTitle("Go to website", for: .normal)
        websiteButton.titleLabel?.textAlignment = .left
        websiteButton.titleLabel?.font = .systemFont(ofSize: 15)
        websiteButton.setTitleColor(UIColor.ecaftRed, for: .normal)
        websiteButton.frame = CGRect(x: horOffSet, y: 0, width: 0.34*screenSize.width, height: 30)
        if(screenSize.height < 667.0) { //iPhone 5s & below
            websiteButton.frame = CGRect(x: horOffSet, y: 0, width: 0.4*screenSize.width, height: 30)
            print("ipohne 5s")
        }
        websiteButton.center.y = 175
        websiteButton.addTarget(self, action: #selector(CompanyInfoTableViewCell.websiteButtonPressed(button:)), for: .touchUpInside)
        
        //Tint image red
        websiteButton.tintColor = UIColor.ecaftRed
        websiteButton.setImage(#imageLiteral(resourceName: "website").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        websiteButton.centerTextAndImage(spacing: 10)
        contentView.addSubview(websiteButton)
        
        
    }
    
    @objc func websiteButtonPressed(button: UIButton!) {
        if let url = NSURL(string: websiteLink!){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
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
