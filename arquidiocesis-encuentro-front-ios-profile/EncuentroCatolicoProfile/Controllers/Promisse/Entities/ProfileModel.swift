//
//  ProfileModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 24/03/21.
//

import UIKit

public struct ProfileModel: Codable {

    public var email : String?
    public var image: String?
    
    init(email: String = "",
         image: String = ""){
        self.email = email
        self.image = image
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case image = "image"
    }
}
