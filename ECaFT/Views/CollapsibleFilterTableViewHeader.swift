//
//  CollapsibleFilterTableViewHeader.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import UIKit

protocol CollapsibleFilterTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleFilterTableViewHeader, section: Int)
}

class CollapsibleFilterTableViewHeader: UITableViewHeaderFooterView {
    var delegate: CollapsibleFilterTableViewHeaderDelegate?
    var section: Int = 0
    let titleLabel = UILabel()
    let arrowImageView = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.ecaftLightGray
        makeArrow()
        makeTitle()
        
        // Call tapHeader when tapping on this header
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:))))
    }
    
    @objc func headerTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleFilterTableViewHeader else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    //If expanded is true, rotate arrow so arrow points up
    func setExpanded(expanded: Bool) {
        //Get angle of arrow (0.0 for pointing up or 180.0 for pointing down)
        if (expanded) {
            arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            
        } else {
            arrowImageView.transform =  CGAffineTransform.identity
        }
    }
    
    private func makeArrow() {
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(arrowImageView)
        arrowImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 17)
        arrowImageView.image = #imageLiteral(resourceName: "DownArrow").withRenderingMode(.alwaysTemplate)
        arrowImageView.tintColor = UIColor.ecaftLightGray2
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    }
    
    private func makeTitle() {
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.ecaftBlack
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
