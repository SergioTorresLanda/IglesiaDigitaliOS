//
//  RSTimeLineRealm.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 21/11/21.
//

import Foundation
import RealmSwift

public class RSTimeLineRealm: Object, Codable{
    @objc dynamic var message = ""
    @objc dynamic var requestId = ""
    @objc dynamic var result: RSResultRealm? = nil
    
//    override public static func primaryKey() -> String? {
//        return "id"
//    }
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case requestId = "requestId"
        case result = "result"
    }
}

public typealias RSTimelinesRealm = [RSTimeLineRealm]

public class RSResultRealm: Object, Codable{
    @objc dynamic var pagination: RSPaginationRealm? = nil
    @objc dynamic var posts: RSPostRealm? = nil
    
    enum CodingKeys: String, CodingKey{
        case pagination = "pagination"
        case posts = "posts"
    }
}

public class RSPaginationRealm: Object, Codable{
    @objc dynamic var hasMore = false
    @objc dynamic var next = ""
    
    enum CodingKeys: String, CodingKey{
        case hasMore = "hasMore"
        case next = "next"
    }
}

public class RSPostRealm: Object, Codable{
    @objc dynamic var id = 0
    @objc dynamic var statusId = 0
    @objc dynamic var reactionId = 0
    @objc dynamic var content = ""
    @objc dynamic var totalComments = 0
    @objc dynamic var totalReactions = 0
    @objc dynamic var createdAt = 0
    @objc dynamic var author: RSAutorRealm? = nil
    @objc dynamic var multimedia: RSMultimediaRealm? = nil
    @objc dynamic var scope: RSScopeRealm? = nil
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case statusId = "statusId"
        case reactionId = "reactionId"
        case content = "content"
        case totalComments = "totalComments"
        case totalReactions = "totalReactions"
        case createdAt = "createdAt"
        case author = "author"
        case multimedia = "multimedia"
        case scope = "scope"
    }
}

public class RSAutorRealm: Object, Codable{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image = ""
    @objc dynamic var type = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case type = "type"
    }
}

public class RSMultimediaRealm: Object, Codable{
    @objc dynamic var id = 0
    @objc dynamic var url = ""
    @objc dynamic var thumbnail = ""
    @objc dynamic var format = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case thumbnail = "thumbnail"
        case format = "format"
    }
}

public class RSScopeRealm: Object, Codable{
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
