//
//  prayerChainModel.swift
//  EncuentroCatolicoHome
//
//  Created by Branchbit on 23/03/21.
//
import RealmSwift
import UIKit

class prayerChainModel: Object {
    
     @objc dynamic var id = 0
     @objc dynamic var date = ""
     @objc dynamic var people = ""
     @objc dynamic var prayer = ""
     @objc dynamic var reason = ""
     @objc dynamic var title = ""
     @objc dynamic var reaction = false
     @objc dynamic var imageFiel = ""
   
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, date, people, prayer, reason, title, imageFiel
    }
}

struct requestError: Codable{
   let message, detail: String
}

// MARK: - prayerDataStruct
struct prayerDataStruct: Codable {
    let data: [Datum]
}
// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let fielName, datumDescription, creationDate: String
    let reaction: Reaction
    let praying: Int
    let imageName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fielName = "fiel_name"
        case datumDescription = "description"
        case creationDate = "creation_date"
        case reaction, praying
        case imageName = "fiel_image_url"
    }
}

// MARK: - Reaction
struct Reaction: Codable {
    let like, dislike: Int
}


