//
//  ListItem.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class ListItem: NSObject, NSCoding {
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
    
    required init?(coder aDecoder: NSCoder) {
        self.companyName = aDecoder.decodeObject(forKey: Property.companyName.rawValue) as? String ?? ""
        self.booth = aDecoder.decodeObject(forKey: Property.booth.rawValue) as? String ?? ""
        self.isSelected = aDecoder.decodeObject(forKey: Property.listItemSelected.rawValue) as? Bool ?? false
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(companyName, forKey: Property.companyName.rawValue)
        aCoder.encode(booth, forKey: Property.booth.rawValue)
        aCoder.encode(isSelected, forKey: Property.listItemSelected.rawValue)
    }
}
