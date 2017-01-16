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
    var informationTextView: UITextView!
    var websiteButton = UIButton()
    var notesButton = UIButton()
    var website: URL!
    
    var information: String? {
        didSet {
            informationTextView.text = information //Sets text of name label to cell's name property
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Hor offset
        let horOffset = 0.05*screenSize.width
        
        //Create industry label
        informationTextView = UITextView(frame: CGRect(x: horOffset, y: 0, width: 0.9*screenSize.width, height: 135))
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
        websiteButton.setTitleColor(UIColor.ecaftRed, for: .normal)
        websiteButton.frame = CGRect(x: horOffset, y: 0, width: 0.41*screenSize.width, height: 30)
        websiteButton.center.y = 175
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
        notesButton.center.y = 175
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
    
    func websiteButtonPressed(button: UIButton!) {
        print("website btn pressed")
        //open company's website
    }
    
    func notesButtonPressed(button: UIButton!) {
        print("notes btn pressed")
        //move to notes section of table
        
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
