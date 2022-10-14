//
//  GroupRealm.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import RealmSwift

//MARK: - GroupRealm
public class GroupRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var active = false
    @objc dynamic var img: String? = nil
    @objc dynamic var members = 0
    @objc dynamic var role = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public typealias Groups = [GroupRealm]

