//
//  FilterOptionItem.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

class Filter: NSObject, NSCoding {
    var title: String = ""
    var searchValue: String? = ""
    
    init(title: String, searchValue: String? = nil) {
        self.title = title
        self.searchValue = searchValue
    }
    
    override init() {
        
    }
    
    required init?(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: Property.filterTitle.rawValue) as? String ?? ""
        self.searchValue = decoder.decodeObject(forKey: Property.filterSearchValue.rawValue) as? String ?? ""
    }
    
    override var description: String {
        return "Title: \(title) | Search Value: \(searchValue ?? "")"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: Property.filterTitle.rawValue)
        coder.encode(searchValue, forKey: Property.filterSearchValue.rawValue)
    }
}

enum FilterType: String, Codable {
    case Majors = "Majors"
    case OpenPositions = "OpenPositions"
    case Sponsorship = "Sponsorship"
}

class FilterOptionItem: NSObject, NSCoding {
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
    
    required init?(coder decoder: NSCoder) {
        self.item = decoder.decodeObject(forKey: Property.filterOptionItem.rawValue) as? Filter ?? Filter()
        self.type = (decoder as! NSKeyedUnarchiver).decodeDecodable(FilterType.self, forKey: Property.itemFilterType.rawValue) ?? .Majors
        self.isSelected = decoder.decodeObject(forKey: Property.isSelected.rawValue) as? Bool ?? true
    }
    
    override var description: String {
        return "Title: \(title) | Search Value: \(searchValue ?? "") | isSelected: \(isSelected)"
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(item, forKey: Property.filterOptionItem.rawValue)
        try? (coder as! NSKeyedArchiver).encodeEncodable(type, forKey: Property.itemFilterType.rawValue)
        coder.encode(isSelected, forKey: Property.isSelected.rawValue)
    }
    
    
}
