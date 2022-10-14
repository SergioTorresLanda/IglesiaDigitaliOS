//
//  CreateServiceBlessModel.swift
//  EncuentroCatolicoServices
//
//  Created by Jorge Garcia on 14/09/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let createServicesBlessModel = try? newJSONDecoder().decode(CreateServicesBlessModel.self, from: jsonData)

import Foundation

// MARK: - CreateServicesBlessModel
struct CreateServicesBlessModel: Codable {
    let familyName, email, phone: String?
    let address: AddressBless?
    let locationID, serviceID: Int?

    enum CodingKeys: String, CodingKey {
        case familyName = "family_name" 
        case email, phone, address
        case locationID = "location_id"
        case serviceID = "service_id"
    }
}

// MARK: - Address
struct AddressBless: Codable {
    let addressDescription, zipcode, neighborhood: String?
    let longitude, latitude: Double?

    enum CodingKeys: String, CodingKey {
        case addressDescription = "description"
        case zipcode, neighborhood, longitude, latitude
    }
}
