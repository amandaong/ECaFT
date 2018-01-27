//
//  ListItem.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class ListItem: NSObject {
    var companyName: String = ""
    var booth: String = ""
    var isSelected: Bool = false
    
    init(companyName: String, booth: String, isSelected: Bool) {
        self.companyName = companyName
        self.booth = booth
        self.isSelected = isSelected
    }
    
    override var description: String {
        return "Company Name: \(companyName) | Booth: \(booth) | isSelected: \(isSelected)"
    }
}
