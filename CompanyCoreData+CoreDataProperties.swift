//
//  CompanyCoreData+CoreDataProperties.swift
//  
//
//  Created by Amanda Ong on 1/11/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CompanyCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyCoreData> {
        return NSFetchRequest<CompanyCoreData>(entityName: "CompanyCoreData");
    }

    @NSManaged public var notes: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?

}
