//
//  ForgotPEntity.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import Foundation

struct UserInfo: Codable {
    var UserAttributes: UserComponents?
}

struct UserComponents: Codable {
    var id: Int?
    var name: String?
    var last_name: String?
    var middle_name: String?
    var phone_number: String?
    var email: String?
    var role: String?
    var profile: String?
    
}

