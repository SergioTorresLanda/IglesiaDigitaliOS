//
//  CommunityFinishRegisterModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let communityFinishRegister = try? newJSONDecoder().decode(CommunityFinishRegister.self, from: jsonData)

import Foundation

// MARK: - CommunityFinishRegister
struct CommunityFinishRegister: Codable {
    var charisma, communityFinishRegisterDescription, address: String?
    var longitude, latitude: Double?
    var email, phone: String?
    var website: String?
    var instagram, twitter, facebook: String?
    var streamingChannel: String?
    var serviceHours: [ServiceHourFinReg]?
    var activities: [ActivityFinReg]?
    var linkedCommunities: [LinkedCommunity]?

    enum CodingKeys: String, CodingKey {
        case charisma
        case communityFinishRegisterDescription = "description"
        case address, longitude, latitude, email, phone, website, instagram, twitter, facebook
        case streamingChannel = "streaming_channel"
        case serviceHours = "service_hours"
        case activities
        case linkedCommunities = "linked_communities"
    }
}

// MARK: - Activity
struct ActivityFinReg: Codable {
    var name, gearedToward, activityDescription: String?
    var serviceHours: [ServiceHourFinReg]?

    enum CodingKeys: String, CodingKey {
        case name
        case gearedToward = "geared_toward"
        case activityDescription = "description"
        case serviceHours = "service_hours"
    }
}

// MARK: - ServiceHour
struct ServiceHourFinReg: Codable {
    var day: Int?
    var schedule: [SchedulefinReg]?
}

// MARK: - Schedule
struct SchedulefinReg: Codable, Hashable {
    var startHour, endHour: String?

    enum CodingKeys: String, CodingKey {
        case startHour = "start_hour"
        case endHour = "end_hour"
    }
}

// MARK: - LinkedCommunity
struct LinkedCommunity: Codable {
    var name, email, phone, leader: String?
}
