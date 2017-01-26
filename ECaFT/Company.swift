//
//  Company.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit
import SwiftyJSON

//Represent the data
class Company: NSObject {
    var name: String = ""
    var information: String = ""
    var location: String = ""
    var positions: [String] = []
    var majors: [String] = []
    var website: String = ""
    var notes: String = ""
    var isFavorite: Bool = false
    var image: UIImage!
    var imageURL: URL!
    
    init(json: JSON) {
        super.init()
        name = json[Property.name.rawValue].stringValue
        information = json[Property.information.rawValue].stringValue
        location = json[Property.location.rawValue].stringValue
        positions = json[Property.positions.rawValue].arrayObject as? [String] ?? []
        majors = json[Property.majors.rawValue].arrayObject as? [String] ?? []
        website = json[Property.website.rawValue].stringValue
        imageURL = URL(string: "http://google.com/\(name)/picture?type=large")
    }
    
    override init() {
        super.init()
    }

    override var description: String {
        return "Name: \(name) | Locations: \(location) | Positions: \(positions) | Majors: \(majors)"
    }
    
    // NSCoding
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Property.name.rawValue) as! String
        information = aDecoder.decodeObject(forKey: Property.information.rawValue) as! String
        location = aDecoder.decodeObject(forKey: Property.location.rawValue) as! String
        positions = aDecoder.decodeObject(forKey: Property.positions.rawValue) as! [String]
        majors = aDecoder.decodeObject(forKey: Property.majors.rawValue) as! [String]
        website = aDecoder.decodeObject(forKey: Property.website.rawValue) as! String
        isFavorite = aDecoder.decodeBool(forKey: Property.isFavorite.rawValue)
        imageURL = aDecoder.decodeObject(forKey: Property.imageURL.rawValue) as! URL
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Property.name.rawValue)
        aCoder.encode(information, forKey: Property.information.rawValue)
        aCoder.encode(location, forKey: Property.location.rawValue)
        aCoder.encode(positions, forKey: Property.positions.rawValue)
        aCoder.encode(majors, forKey: Property.majors.rawValue)
        aCoder.encode(website, forKey: Property.website.rawValue)
        aCoder.encode(isFavorite, forKey: Property.isFavorite.rawValue)
        aCoder.encode(imageURL, forKey: Property.imageURL.rawValue)
    }
}

//Put names of propertiesin enum to avoid typos
enum Property: String {
    case filteredCompanies = "filteredCompanies"
    case name = "name"
    case filtersApplied = "filtersApplied"
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
}
