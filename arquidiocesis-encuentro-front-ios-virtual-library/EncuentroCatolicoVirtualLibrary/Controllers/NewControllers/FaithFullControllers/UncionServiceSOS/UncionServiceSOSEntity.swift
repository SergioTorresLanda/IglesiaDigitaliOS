//
//  UncionServiceSOSEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import Foundation

struct ServiceDetailFaithful: Codable {
    var id: Int?
    var address: AddressCompSOServices?
    var creation_date: String?
    var support_contact: SupportFaithful?
    var progress_history: [ProgressHFaithful]?
    var service: ServiceCompoents?
}

struct AddressCompSOServices: Codable {
    var description : String?
    var longitude: Double?
    var latitude: Double?
}

struct SupportFaithful: Codable {
    var contact_id: Int?
    var name: String?
}

struct ProgressHFaithful: Codable {
    var status: String?
    var sub_status: String?
}

struct ServiceCompoents: Codable {
    var id: Int?
    var name: String?
}

