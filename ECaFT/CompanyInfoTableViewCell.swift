//
//  CompanyInfoTableViewCell.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/7/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit

class CompanyInfoTableViewCell: UITableViewCell {
    let screenSize : CGRect = UIScreen.main.bounds
    var industryLabel: UILabel!
    var industry = ""
    var hqLabel: UILabel!
    var hq = ""
    var websiteButton = UIButton()
    var notesButton = UIButton()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Hor offset
        let horOffset = 0.05*screenSize.width
        
        //Create industry label
        industryLabel = UILabel(frame: CGRect(x: horOffset, y: 0, width: 0.8*screenSize.width, height: 21))
        industryLabel.center.y = 22
        industryLabel.textAlignment = .left
        industryLabel.textColor = UIColor.ecaftDarkGray
        contentView.addSubview(industryLabel)

        //Create headquarters label
        hqLabel = UILabel(frame: CGRect(x: horOffset, y: 0, width: 0.8*screenSize.width, height: 21))
        hqLabel.center.y = 47
        hqLabel.textAlignment = .left
        hqLabel.textColor = UIColor.ecaftDarkGray
        contentView.addSubview(hqLabel)
        
        //Create website button
        websiteButton.setTitle("Go to website", for: .normal)
        websiteButton.titleLabel?.textAlignment = .left
        websiteButton.setTitleColor(UIColor.ecaftRed, for: .normal)
        websiteButton.frame = CGRect(x: horOffset, y: 0, width: 0.41*screenSize.width, height: 30)
        websiteButton.center.y = 82
        websiteButton.addTarget(self, action: #selector(CompanyInfoTableViewCell.websiteButtonPressed(button:)), for: .touchUpInside)
        
        //Tint image red
        websiteButton.tintColor = UIColor.ecaftRed
        websiteButton.setImage(#imageLiteral(resourceName: "website").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        websiteButton.centerTextAndImage(spacing: 10)
        contentView.addSubview(websiteButton)
        
        //Create notes button
        notesButton.setTitle("Add notes", for: .normal)
        notesButton.titleLabel?.textAlignment = .left
        notesButton.setTitleColor(UIColor.ecaftRed, for: .normal)
        notesButton.frame = CGRect(x: 0.6*screenSize.width, y: 0, width: 0.35*screenSize.width, height: 30)
        notesButton.center.y = 82
        notesButton.addTarget(self, action: #selector(CompanyInfoTableViewCell.notesButtonPressed(button:)), for: .touchUpInside)
        
        //Tint image red
        notesButton.tintColor = UIColor.ecaftRed
        notesButton.setImage(#imageLiteral(resourceName: "notes").withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        //Move image to right of text
        notesButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        notesButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        notesButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        notesButton.centerTextAndImage(spacing: 10)
        contentView.addSubview(notesButton)
    }
    func loadInfo(industry: String, hq: String) { //DATA LOADING: add website: URL so website button brings up website
        self.industry = industry
        
        //Bold "Industry:" of industry label
        industryLabel.attributedText = boldPartOfText(boldedText: "Industry: ", normalText: industry, fontSize: 15) //DATA LOADING: company.industry. Need to add industry property to company.swift file and change let normalText and normalString to var
        self.hq = hq
        hqLabel.attributedText = boldPartOfText(boldedText: "Headquarters: ", normalText: hq, fontSize: 15) //bold "Headquarters:" of hq label //DATA LOADING: company.hq
        
    }
    func websiteButtonPressed(button: UIButton!) {
        print("website btn pressed")
        //open company's website
    }
    
    func notesButtonPressed(button: UIButton!) {
        print("notes btn pressed")
        //move to notes section of table
        
    }
    
    func boldPartOfText(boldedText: String, normalText: String, fontSize: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: boldedText, attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: fontSize)])
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black, range: NSRange(location:0,length: boldedText.characters.count))
        let normalString = NSMutableAttributedString(string: normalText)
        attributedString.append(normalString)
        return attributedString
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
