//
//  NewDonationsEntity.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.
//

import Foundation

struct ChurchesDontaions: Codable {
    var assigned: AssignedDonations?
    var locations: [LocationsDontaions]?
}

struct AssignedDonations: Codable {
    var id: Int?
    var name: String?
    var mi_ofrenda_id: Int?
    var image_url: String?
    var schedules: [SchedulesDontaions]?
}

struct LocationsDontaions: Codable {
    var id: Int?
    var name: String?
    var mi_ofrenda_id: Int?
    var image_url: String?
    var schedules: [SchedulesDontaions]?
}

struct SchedulesDontaions: Codable {
    var start_hour: String?
    var end_hour: String?
}

struct ChurchesSuggested: Codable {
    var id: Int?
    var name: String?
    var image_url: String?
    var type: String?
}


// MARK: BILLING DATA -
struct BillingData: Codable {
    var id: Int?
    var business_name: String?
    var rfc: String?
    var address: String?
    var neighborhood: String?
    var zipcode: String?
    var municipality: String?
    var email: String?
    var automatic_invoicing: Bool?
}

// MARK: - PaymetResponse
struct PaymetResponse: Codable {
    let success: Bool
    let response: Response
}
struct Response: Codable {
    let status, invoice, code, responseDescription: String?
    let operationID: String?

    enum CodingKeys: String, CodingKey {
        case status, invoice, code
        case responseDescription = "description"
        case operationID = "operation_id"
    }
}
