//
//  FilterSection.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class FilterSection: NSObject, NSCoding {
    var name: String = ""
    var items: [FilterOptionItem] = []
    var type: FilterType = .Majors // Assign default values for NSCoding
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
    
    required init?(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: Property.filterName.rawValue) as? String ?? ""
        self.items = decoder.decodeObject(forKey: Property.filterOptionItems.rawValue) as? [FilterOptionItem] ?? []
        self.type = (decoder as! NSKeyedUnarchiver).decodeDecodable(FilterType.self, forKey: Property.sectionFilterType.rawValue) ?? .Majors
        self.isAllSelected = decoder.decodeObject(forKey: Property.isAllSelected.rawValue) as? Bool ?? true
        self.isExpanded = decoder.decodeObject(forKey: Property.isExpanded.rawValue) as? Bool ?? false
    }
    
    override var description: String {
        return "Name: \(name) | Items: \(items) | Type: \(type) | isAllSelected: \(isAllSelected) | isExpanded: \(isExpanded)"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: Property.filterName.rawValue)
        coder.encode(items, forKey: Property.filterOptionItems.rawValue)
        try? (coder as! NSKeyedArchiver).encodeEncodable(type, forKey: Property.sectionFilterType.rawValue)
        coder.encode(isAllSelected, forKey: Property.isAllSelected.rawValue)
        coder.encode(isExpanded, forKey: Property.isExpanded.rawValue)
    }
}
