//
//  FilterOptionItem.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

struct Filter {
    var title: String
    var searchValue: String?
    
    init(title: String, searchValue: String? = nil) {
        self.title = title
        self.searchValue = searchValue
    }
}

enum FilterType {
    case Majors
    case OpenPositions
    case Sponsorship
}

class FilterOptionItem {
    private var item: Filter
    var isSelected: Bool = true
    
    var title: String {
        return item.title
    }
    var searchValue: String? {
        return item.searchValue
    }
    
    var type: FilterType
    
    init(item: Filter, type: FilterType, isSelected: Bool? = true) {
        self.item = item
        self.type = type
        self.isSelected = isSelected ?? true
    }
}
