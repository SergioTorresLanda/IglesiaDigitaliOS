//
//  UserListStruct.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 24/06/21.
//

import Foundation

struct UserList: Codable {
    let id: Int?
    let name: String?
    let first_surname: String?
    let second_surname: String?
    let is_admin: Bool?
    let is_super_admin: Bool?
}
