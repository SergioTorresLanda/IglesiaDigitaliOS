//
//  CommunityDetailModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 23/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let communityDetailModel = try? newJSONDecoder().decode(CommunityDetailModel.self, from: jsonData)

import Foundation

// MARK: - CommunityDetailModel
struct CommunityDetailModel: Codable {
    let id: Int?
    let name, instituteOrAssociation, imageURL, charisma: String?
    let leader: String?
    let type: TypeClass?
    let communityDetailModelDescription, address: String?
    let latitude, longitude: Double?
    let email, phone, website, facebook: String?
    let twitter, instagram, streamingChannel: String?
    let reviewing: Bool?
    let serviceHours: [ServiceHour]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case instituteOrAssociation = "institute_or_association"
        case imageURL = "image_url"
        case charisma, leader, type
        case communityDetailModelDescription = "description"
        case address, latitude, longitude, email, phone, website, facebook, twitter, instagram
        case streamingChannel = "streaming_channel"
        case reviewing
        case serviceHours = "service_hours"
    }
}

// MARK: - ServiceHour
struct ServiceHour: Codable {
    let day: Int?
    let schedules: [Schedule]?
}

// MARK: - Schedule
struct Schedule: Codable {
    let hourStart, hourEnd: String?

    enum CodingKeys: String, CodingKey {
        case hourStart = "hour_start"
        case hourEnd = "hour_end"
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    var id: Int?
    var name: String?
}

struct UploadImageData: Codable {
    var url : String?
}
