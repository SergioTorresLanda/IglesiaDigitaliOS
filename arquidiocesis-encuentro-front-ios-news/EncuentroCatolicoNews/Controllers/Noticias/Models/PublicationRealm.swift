//
//  PublicationRealm.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 26/11/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

import RealmSwift

// MARK: - PublicationRealm
public class PublicationRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var countView = 0
    @objc dynamic var active = false
    @objc dynamic var countComment = 0
    @objc dynamic var type = ""
    @objc dynamic var content = ""
    @objc dynamic var countReact = 0
    @objc dynamic var status = ""
    @objc dynamic var autor: AutorRealm? = nil
    @objc dynamic var area: AreaRealm? = nil
    var mediaList = List<MediaRealm>()
    @objc dynamic var location: LocationRealm? = nil
    @objc dynamic var myReaction: MyReactionRealm? = nil
    @objc dynamic var feeling: FeelingRealm? = nil
    @objc dynamic var created = 0
    @objc dynamic var asParam = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, active, countComment, type, content, countReact, status, autor, area
        case mediaList = "media"
        case location, myReaction, feeling, created
        case asParam = "as"
    }
}

public typealias PublicationsRealm = [PublicationRealm]

// MARK: - Area
public class AreaRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var active = false
    @objc dynamic var img: String? = nil
}

// MARK: - Feeling
public class FeelingRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var img = ""
    @objc dynamic var type = ""
}

// MARK: - Location
public class LocationRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var imgLocation: String? = nil
    @objc dynamic var idLocation: String? = nil
    @objc dynamic var lng = 0.0
    @objc dynamic var lat = 0.0
    @objc dynamic var direction: String? = nil
    @objc dynamic var nameLocation: String? = nil
}

// MARK: - Media
public class MediaRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var url = ""
    @objc dynamic var mimeType = ""
}

// MARK: - MyReaction
public class MyReactionRealm: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var json = ""
    @objc dynamic var active = false
    @objc dynamic var img = ""
    @objc dynamic var color = ""
    @objc dynamic var type = ""
}

// MARK: - Autor
public class AutorRealm: Object, Codable {
    @objc dynamic var FIIDEMPLEADO = 0
    @objc dynamic var nombre = ""
    @objc dynamic var imagen: String? = nil
}
