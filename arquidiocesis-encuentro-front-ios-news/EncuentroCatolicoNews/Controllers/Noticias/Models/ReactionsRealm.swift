//
//  ReactionsRealm.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import RealmSwift

// MARK: - ReactionsRealm
public class ReactionsRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var json = ""
    @objc dynamic var active = false
    @objc dynamic var img = ""
    @objc dynamic var color = ""
    @objc dynamic var type = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public typealias Reactions = [ReactionsRealm]
