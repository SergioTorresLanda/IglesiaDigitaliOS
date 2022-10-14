//
//  AdminServices.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 02/07/21.
//

import Foundation

struct GetPrincipalChurch: ResponseDispatcher {
    typealias ResponseType = AssignedChurches
    var parameters: [String : Any]?
    var urlOptional: String?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/locations/" + self.id , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}
