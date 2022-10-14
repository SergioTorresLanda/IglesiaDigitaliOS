//
//  ImageSaintsModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit


struct ImageSaintsModel: Codable {

    var id: Int?
    var imageCode: String?
    
    init(id:Int, imageCode:String) {
        self.imageCode = imageCode
        self.id = id
    }
    
    
    enum CodingKeys: String, CodingKey {
        case imageCode = "imageCode"
        case id = "id"
    }
    
}
