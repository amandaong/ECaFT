//
//  List.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/26/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class List: NSObject {
    var title: String = ""
    var items: [ListItem] = []
    var isSelected = false
    
    init(title: String, items: [ListItem], isSelected: Bool) {
        self.title = title
        self.items = items
        self.isSelected = isSelected
    }
    
    override var description: String {
        return "Title: \(title) | Items: \(items) | isSelected: \(isSelected)"
    }
}
