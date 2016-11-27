//
//  Company.swift
//  ECaFT
//
//  Created by Logan Allen on 11/22/16.
//  Copyright © 2016 loganallen. All rights reserved.
//

import UIKit
import SwiftyJSON

class Company: NSObject {
    var name: String = ""
    var hq: String = ""
    var locations: [String] = []
    var positions: [String] = []
    var majors: [String] = []
    var notes: String = ""
    var isFavorite: Bool = false
    var imageURL: URL!
    
    init(json: JSON) {
        super.init()
        name = json["name"].stringValue
        hq = json["hq"].stringValue
        locations = json["locations"].arrayObject as? [String] ?? []
        positions = json["positions"].arrayObject as? [String] ?? []
        majors = json["majors"].arrayObject as? [String] ?? []
        imageURL = URL(string: "http://google.com/\(name)/picture?type=large")
    }
    
    override var description: String {
        return "Name: \(name) | HQ: \(hq) | Locations: \(locations) | Positions: \(positions) | Majors: \(majors)"
    }
    
    // NSCoding
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        hq = aDecoder.decodeObject(forKey: "hq") as! String
        locations = aDecoder.decodeObject(forKey: "locations") as! [String]
        positions = aDecoder.decodeObject(forKey: "positions") as! [String]
        majors = aDecoder.decodeObject(forKey: "majors") as! [String]
        notes = aDecoder.decodeObject(forKey: "notes") as! String
        isFavorite = aDecoder.decodeObject(forKey: "isFavorite") as! Bool
        imageURL = aDecoder.decodeObject(forKey: "imageURL") as! URL
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(hq, forKey: "hq")
        aCoder.encode(locations, forKey: "locations")
        aCoder.encode(positions, forKey: "positions")
        aCoder.encode(majors, forKey: "majors")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(isFavorite, forKey: "isFavorite")
        aCoder.encode(imageURL, forKey: "imageURL")
    }
    
}
