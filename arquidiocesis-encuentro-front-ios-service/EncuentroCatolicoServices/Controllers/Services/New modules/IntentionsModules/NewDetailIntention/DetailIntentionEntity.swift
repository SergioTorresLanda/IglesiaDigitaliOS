//
//  DetailIntentionEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

struct IntentionDetails: Codable {
    var location: String?
    var mass_date: String?
    var mass_schedule: String?
    var intentions: [Intentions]?
}

struct Intentions: Codable {
    var intention: String?
    var dedicated_to: [String]?
}

struct PDFObject: Codable {
    var url: String?
}
