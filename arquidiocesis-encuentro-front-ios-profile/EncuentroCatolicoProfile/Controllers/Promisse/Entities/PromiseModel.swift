//
//  PromiseModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

struct PromiseModel:Codable {

    var dateStarted : Date?
    var flag: Bool?
    var periodInterval: String?
    var promisseDescription: String?
    var promisseTo: String
    var promisseToIdentifier: Int?
    var profileID: String?
    var dateEnd: Date?
    var imageSaint: String?

    
    init(dateStarted: Date = Date(),
         flag: Bool = false,
         periodInterval: String = "",
         promisseDescription: String = "",
         promisseTo: String = "",
         promisseToIdentifier: Int = 0,
         profileID: String = "",
         imageSaint: String = "001",
         dateEnd: Date = Date()){
        self.dateStarted = dateStarted
        self.flag = flag
        self.periodInterval = periodInterval
        self.promisseDescription = promisseDescription
        self.promisseTo = promisseTo
        self.promisseToIdentifier = promisseToIdentifier
        self.profileID = profileID
        self.imageSaint = imageSaint
        self.dateEnd = dateEnd
    }
    
    enum CodingKeys: String, CodingKey {
        case dateStarted = "dateStarted"
        case flag = "flag"
        case periodInterval = "periodInterval"
        case promisseDescription = "promisseDescription"
        case promisseTo = "promisseTo"
        case promisseToIdentifier = "promisseToIdentifier"
        case profileID = "profileID"
        case imageSaint = "imageSaint"
        case dateEnd = "dateEnd"
    }
}
