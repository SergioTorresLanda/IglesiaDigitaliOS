//
//  PriestPSOSEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import Foundation
import UIKit

struct ListSrevices: Codable {
    var id: Int?
    var status: String?
    var sub_status: String?
    var funeral_home: String?
    var service: ServiceDetail?
    var location: LocationChurch?
    var devotee: DevoteeDetail?
    var modification_date: String?
    var priest: PriestComponents?
    
}

struct ServiceDetail: Codable {
    var id: Int?
    var name: String?
    var type: String?
}

struct LocationChurch: Codable{
    var id: Int?
    var name: String?
    var image_url: String?
    var distance: String?
}

struct DevoteeDetail: Codable {
    var devotee_id: Int?
    var name: String?
    var phone: String?
}

struct PriestComponents: Codable {
    var priest_id: Int?
    var name: String?
}
