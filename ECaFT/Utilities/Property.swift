//
//  Property.swift
//  ECaFT
//
//  Created by Amanda Ong on 1/12/18.
//  Copyright © 2018 ECAFT. All rights reserved.
//

import Foundation

//Put names of properties in enum to avoid typos
enum Property: String {
    case name = "name"
    case isChecked = "isChecked"
    case favorites = "favorites"
    case information = "information"
    case location = "location"
    case positions = "positions"
    case majors = "majors"
    case notes = "notes"
    case appliedFilters = "appliedFilters"
    case isFavorite = "isFavorite"
    case imageURL = "imageURL"
    case jobtypes = "jobtypes"
    case website = "website"
    case id = "id"
    case sponsor = "sponsor"
    case optcpt = "optcpt"
    
    // Filter Section
    case filterName = "filterName"
    case filterOptionItems = "filterOptionItems"
    case sectionFilterType = "sectionFilterType"
    case isAllSelected = "isAllSelected"
    case isExpanded = "isExpanded"
    
    // Filter Option Item
    case filterOptionItem = "filterOptionItem"
    case itemFilterType = "itemFilterType"
    case isSelected = "isSelected"
    
    // Filter Data Object
    case filterTitle = "filterTitle"
    case filterSearchValue = "filterSearchValue"

}
