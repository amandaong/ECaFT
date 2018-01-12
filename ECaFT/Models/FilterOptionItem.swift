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
}

enum FilterType {
    case Majors
    case OpenPositions
    case Sponsorship
}

class FilterOptionItem {
    private var item: Filter
    var isSelected = false
    var title: String {
        return item.title
    }
    var type: FilterType
    
    init(item: Filter, type: FilterType) {
        self.item = item
        self.type = type
    }
}
