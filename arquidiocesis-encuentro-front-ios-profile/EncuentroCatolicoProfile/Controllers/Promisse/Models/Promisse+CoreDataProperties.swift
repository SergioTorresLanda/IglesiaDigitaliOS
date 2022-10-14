//
//  Promisse+CoreDataProperties.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//
//

import Foundation
import CoreData


extension Promisse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Promisse> {
        return NSFetchRequest<Promisse>(entityName: "Promisse")
    }
    
    @NSManaged public var dateEnd: Date?
    @NSManaged public var promisseDescription: String?
    @NSManaged public var promisseTo: String?
    @NSManaged public var dateStarted: Date?
    @NSManaged public var flag: Bool
    @NSManaged public var periodInterval: String?
    @NSManaged public var promisseToIdentifier: Int32
    @NSManaged public var profileID: String?
    @NSManaged public var imageSaint: String?

}
