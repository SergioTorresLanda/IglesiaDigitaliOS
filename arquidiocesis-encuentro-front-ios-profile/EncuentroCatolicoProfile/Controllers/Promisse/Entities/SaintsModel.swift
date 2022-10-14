//
//  SaintsModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

struct SaintsModel: Codable {

    var id: Int?
    var name: String?
    
    init(id:Int, name:String) {
        self.name = name
        self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
