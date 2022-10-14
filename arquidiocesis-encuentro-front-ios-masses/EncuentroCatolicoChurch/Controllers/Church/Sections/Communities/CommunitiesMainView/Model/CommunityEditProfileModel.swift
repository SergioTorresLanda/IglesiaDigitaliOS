//
//  CommunityEditProfileModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let communityEditProfile = try? newJSONDecoder().decode(CommunityEditProfile.self, from: jsonData)

import Foundation

// MARK: - CommunityEditProfile
struct CommunityEditProfile: Codable {
    var typeID: Int?
    var communityEditProfileDescription, charisma, address: String?
    var longitude, latitude: Double?
    var email, phone: String?
    var website: String?
    var instagram, twitter, facebook, streamingChannel: String?
    var serviceHours: [ServiceHourEditProfile]?
    var activities: [ActivityEditProfile]?

    enum CodingKeys: String, CodingKey {
        case typeID = "type_id"
        case communityEditProfileDescription = "description"
        case charisma, address, longitude, latitude, email, phone, website, instagram, twitter, facebook
        case streamingChannel = "streaming_channel"
        case serviceHours = "service_hours"
        case activities
    }
}

// MARK: - Activity
struct ActivityEditProfile: Codable {
    var name, gearedToward, activityDescription: String?
    var serviceHours: [ServiceHourEditProfile]?

    enum CodingKeys: String, CodingKey {
        case name
        case gearedToward = "geared_toward"
        case activityDescription = "description"
        case serviceHours = "service_hours"
    }
}

// MARK: - ServiceHour
struct ServiceHourEditProfile: Codable {
    var day: Int?
    var schedule: [ScheduleEditPrifile]?
}

// MARK: - Schedule
struct ScheduleEditPrifile: Codable, Hashable {
    var startHour, endHour: String?

    enum CodingKeys: String, CodingKey {
        case startHour = "start_hour"
        case endHour = "end_hour"
    }
}

