//
//  FilterSection.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class FilterSection {
    var isAllSelected: Bool = true
    var isExpanded: Bool = false
    var name: String
    var items: [FilterOptionItem]
    
    init(name: String, items: [FilterOptionItem]) {
        self.name = name
        self.items = items
    }
}
