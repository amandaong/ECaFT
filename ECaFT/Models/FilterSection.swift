//
//  FilterSection.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class FilterSection {
    var name: String
    var items: [FilterOptionItem]
    var type: FilterType
    var isAllSelected: Bool = true
    var isExpanded: Bool = false
    
    init(name: String, items: [FilterOptionItem], type: FilterType) {
        self.name = name
        self.items = items
        self.type = type
    }
    
    init(name: String, items: [FilterOptionItem], type: FilterType, isAllSelected: Bool, isExpanded: Bool) {
        self.name = name
        self.items = items
        self.type = type
        self.isAllSelected = isAllSelected
        self.isExpanded = isExpanded
    }
}
