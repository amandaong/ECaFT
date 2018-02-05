//
//  Company.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 ECAFT. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Major: String {
    case be = "biological engineering"
    case bme = "biomedical engineering"
    case cheme = "chemical engineering"
    case ce = "civil engineering"
    case cs = "computer science"
    case ece = "electrical and computer engineering"
    case phy = "physics"
    case enve = "environmental engineering"
    case isst = "information science systems and technology"
    case mse = "materials science and engineering"
    case me = "mechanical engineering"
    case ore = "operations research and engineering"
    case ses = "science of earth systems"
    case bs = "biological sciences"
    case gd = "game design"
    case math = "mathematics"
    case bio = "biology"
    case chem = "chemistry"
    case ss = "statistical science"
    case infosci = "information science"
    case astro = "astronomy"
}

enum Position: String {
    case fullTime = "full time"
    case internship = "internship"
    case coop = "co-op"
}

//Represent the data
class Company: NSObject, NSCoding {
    var name: String = ""
    var information: String = ""
    var location: String = ""
    var positions: [String] = []
    var majors: [String] = []
    var website: String = ""
    var sponsor: Bool = false
    var optcpt: Bool = false

    var notes: String = ""
    var isFavorite: Bool = false
    var image: UIImage!
    var imageURL: URL!
    
    //add background image
    var background: UIImage!
    
    init(json: JSON) {
        super.init()
        name = json[Property.name.rawValue].stringValue
        information = json[Property.description.rawValue].stringValue
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
        information = aDecoder.decodeObject(forKey: Property.description.rawValue) as! String
        location = aDecoder.decodeObject(forKey: Property.location.rawValue) as! String
        positions = aDecoder.decodeObject(forKey: Property.positions.rawValue) as! [String]
        majors = aDecoder.decodeObject(forKey: Property.majors.rawValue) as! [String]
        website = aDecoder.decodeObject(forKey: Property.website.rawValue) as! String
        isFavorite = aDecoder.decodeBool(forKey: Property.isFavorite.rawValue)
        imageURL = aDecoder.decodeObject(forKey: Property.imageURL.rawValue) as! URL
        sponsor = aDecoder.decodeBool(forKey: Property.sponsor.rawValue)
        optcpt = aDecoder.decodeBool(forKey: Property.optcpt.rawValue)

    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Property.name.rawValue)
        aCoder.encode(information, forKey: Property.description.rawValue)
        aCoder.encode(location, forKey: Property.location.rawValue)
        aCoder.encode(positions, forKey: Property.positions.rawValue)
        aCoder.encode(majors, forKey: Property.majors.rawValue)
        aCoder.encode(website, forKey: Property.website.rawValue)
        aCoder.encode(isFavorite, forKey: Property.isFavorite.rawValue)
        aCoder.encode(imageURL, forKey: Property.imageURL.rawValue)
        aCoder.encode(sponsor, forKey: Property.sponsor.rawValue)
        aCoder.encode(optcpt, forKey: Property.optcpt.rawValue)
    }
}


