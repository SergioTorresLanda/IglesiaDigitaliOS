//
//  CommunitiesGetActivitiesModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 26/08/21.
//

import Foundation

import Foundation

// MARK: - CommunityGetActivity
struct CommunityGetActivity: Codable {
    var id: Int?
    var name, gearedToward, communityGetActivityDescription: String?
    var serviceHours: [ServiceHourActivity]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case gearedToward = "geared_toward"
        case communityGetActivityDescription = "description"
        case serviceHours = "service_hours"
    }
}

// MARK: - ServiceHour
struct ServiceHourActivity: Codable {
    var id, day: Int?
    var schedules: [ScheduleActivity]?
}

// MARK: - Schedule
struct ScheduleActivity: Codable {
    var hourStart, hourEnd: String?

    enum CodingKeys: String, CodingKey {
        case hourStart = "hour_start"
        case hourEnd = "hour_end"
    }
}

typealias CommunityGetActivities = [CommunityGetActivity]

