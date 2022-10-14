//
//  ProfileMatchData.swift
//  EncuentroCatolicoNews
//
//  Created by 4n4rk0z on 26/11/21.
//

import Foundation


// MARK: - ProfileMatchData
struct ProfileMatchData: Codable {
    let message, requestID: String?
    let result: ProfileResult?

    enum CodingKeys: String, CodingKey {
        case message
        case requestID = "requestId"
        case result
    }
}

// MARK: - Result
struct ProfileResult: Codable {
    let fullName, email: String?
    let id: Int?
    let lastName, name: String?
    let personID: Int?
    let phoneNumber, role, secondLastName, image: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case fullName, email, id, lastName, name
        case personID = "personId"
        case phoneNumber, role, secondLastName, image, thumbnail
    }
}
