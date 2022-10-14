//
//  ScheduleMassTimeEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Ricardo Ramirez on 10/05/21.
//

import Foundation

struct ServicesRequest: Codable {
    var intention_type = "MENTION"
    let dedicated_to: String
    let mass_date: String
    let mass_schedule: String
    let location_id: Int
    let service_id: Int
}

struct LocationServicesRequest: Codable {
    let id: Int
}

struct DevoteeServicesRequest: Codable {
    let devotee_id: Int
}

struct ServicesResponse: Codable {
    let service_id: Int
}

struct CatalogIntentions: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var action: String?
}

struct ListIntentions2: Codable {
    var date: String?
    var start_time: String?
    var end_time: String?
    var priest: PriestData2?
}

struct PriestData2: Codable {
    var id: String?
    var name: String?
    var first_surname: String?
    var second_surname: String?
}
