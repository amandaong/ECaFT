//
//  FilterOptionItem.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class Filter: NSObject {
    var title: String = ""
    var searchValue: String? = ""
    
    init(title: String, searchValue: String? = nil) {
        self.title = title
        self.searchValue = searchValue
    }
    
    override init() {
        
    }
    
    override var description: String {
        return "Title: \(title) | Search Value: \(searchValue ?? "")"
    }
    
}

enum FilterType: String {
    case Majors = "Majors"
    case OpenPositions = "OpenPositions"
    case Sponsorship = "Sponsorship"
}

class FilterOptionItem: NSObject {
    private var item: Filter = Filter()
    var isSelected: Bool = true
    
    var title: String {
        return item.title
    }
    var searchValue: String? {
        return item.searchValue
    }
    
    var type: FilterType = .Majors // Set initial value for NSCoding
    
    init(item: Filter, type: FilterType, isSelected: Bool = true) {
        self.item = item
        self.type = type
        self.isSelected = isSelected
    }
    
    override var description: String {
        return "Title: \(title) | Search Value: \(searchValue ?? "") | isSelected: \(isSelected)"
    }
    
}
