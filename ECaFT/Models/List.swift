//
//  List.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class List: NSObject, NSCoding {
    var title: String = ""
    var items: [ListItem] = []
    var isSelected = false
    
    override init() {
        super.init()
    }
    
    init(title: String, items: [ListItem], isSelected: Bool) {
        self.title = title
        self.items = items
        self.isSelected = isSelected
    }
    
    override var description: String {
        return "Title: \(title) | Items: \(items) | isSelected: \(isSelected)"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Property.listTitle.rawValue)
        aCoder.encode(items, forKey: Property.listItems.rawValue)
        aCoder.encode(isSelected, forKey: Property.listSelected.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: Property.listTitle.rawValue) as? String ?? ""
        self.items = aDecoder.decodeObject(forKey: Property.listItems.rawValue) as? [ListItem] ?? []
        self.isSelected = aDecoder.decodeObject(forKey: Property.listSelected.rawValue) as? Bool ?? false
    }
}
