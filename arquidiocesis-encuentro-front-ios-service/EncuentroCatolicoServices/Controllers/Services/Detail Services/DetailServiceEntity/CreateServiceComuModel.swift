//
//  CreateServiceModel.swift
//  EncuentroCatolicoServices
//
//  Created by Jorge Garcia on 14/09/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let createServicesComuModel = try? newJSONDecoder().decode(CreateServicesComuModel.self, from: jsonData)

import Foundation

// MARK: - CreateServicesComuModel
struct CreateServicesComuModel: Codable {
    let personName, email, phone, explanation: String?
    let serviceID, locationID: Int?
    let address: AddressComu?

    enum CodingKeys: String, CodingKey {
        case personName = "person_name"
        case email, phone, explanation
        case serviceID = "service_id"
        case locationID = "location_id"
        case address
    }
}

// MARK: - Address
struct AddressComu: Codable {
    let addressDescription, zipcode, neighborhood: String?
    let longitude, latitude: Double?

    enum CodingKeys: String, CodingKey {
        case addressDescription = "description"
        case zipcode, neighborhood, longitude, latitude
    }
}
