//
//  UncionSOSEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import Foundation

struct ListChurches: Codable {
    var id: Int
    var name: String?
    var phone: String?
    var distance: Double?
    var image_url: String?
    var schedules: [SchedulesSOS]?
    var support_contacts : [Support]
    
}

struct Support: Codable {
    var id: Int?
    var name: String?
}

struct SchedulesSOS: Codable {
    var id: Int?
}


struct ServiceResponse: Codable{
    var service_id: Int
    
    enum CodingKeys: String, CodingKey {
        case service_id = "service_id"
        
    }
}
