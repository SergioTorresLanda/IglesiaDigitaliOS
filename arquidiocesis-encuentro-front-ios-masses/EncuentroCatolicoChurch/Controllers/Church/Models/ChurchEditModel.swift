//
//  ChurchEditModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 12/09/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let churchEditModel = try? newJSONDecoder().decode(ChurchEditModel.self, from: jsonData)

import Foundation

// MARK: - ChurchEditModel
struct ChurchEditModel: Codable {
    let churchEditModelDescription, email, phone, stream: String?
    let website, facebook, twitter, intagram: String?
    let bankAccount: String?
    let principal: PrincipalEditChurch?
    let schedules, attention: [AttentionEditChurch]?
    let masses: [MassEditChurch]?
    let services: [ServiceEditChurch]?

    enum CodingKeys: String, CodingKey {
        case churchEditModelDescription = "description"
        case email, phone, stream, website, facebook, twitter
        case intagram = "instagram"
        case bankAccount = "bank_account"
        case principal, schedules, attention, masses, services
    }
}

// MARK: - Attention
struct AttentionEditChurch: Codable, Hashable {
    let days: [DayEditChurch]?
    let hourStart, hourEnd: String?

    enum CodingKeys: String, CodingKey {
        case days
        case hourStart = "hour_start"
        case hourEnd = "hour_end"
    }
}

// MARK: - Day
struct DayEditChurch: Codable, Hashable {
    let id: Int?
    let name: String?
    let checked: Bool?
}

// MARK: - Mass
struct MassEditChurch: Codable, Hashable {
    let days: [DayEditChurch]?
    let hourStart: String?
    let hourEnd: String?

    enum CodingKeys: String, CodingKey {
        case days
        case hourStart = "hour_start"
        case hourEnd = "hour_end"
    }
}

// MARK: - Principal
struct PrincipalEditChurch: Codable {
    var id: Int?
}

// MARK: - Service
struct ServiceEditChurch: Codable {
    let type: TypeClassEditChurch?
    let gearedToward, serviceDescription: String?
    let schedules: [AttentionEditChurch]?

    enum CodingKeys: String, CodingKey {
        case type
        case gearedToward = "geared_toward"
        case serviceDescription = "description"
        case schedules
    }
}

// MARK: - TypeClass
struct TypeClassEditChurch: Codable {
    var id: Int?
    var name: String?
}
