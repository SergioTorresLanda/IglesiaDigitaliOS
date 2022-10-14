//
//  CommunityTypeModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/08/21.
//


import Foundation

// MARK: - CommunityTypeModel
struct CommunityTypeModel: Codable {
    var name, address: String?
    var longitude, latitude: Double?
    var email, phone: String?
    var type: Int?
}

