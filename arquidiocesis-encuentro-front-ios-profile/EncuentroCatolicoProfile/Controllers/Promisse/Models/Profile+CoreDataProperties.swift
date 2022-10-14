//
//  Profile+CoreDataProperties.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 24/03/21.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var email: String?

}
