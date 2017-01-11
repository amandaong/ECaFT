//
//  CompanyData+CoreDataProperties.swift
//  
//
//  Created by Amanda Ong on 1/11/17.
//
//

import Foundation
import CoreData


extension CompanyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyData> {
        return NSFetchRequest<CompanyData>(entityName: "CompanyData");
    }

    @NSManaged public var name: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var notes: String?

}
