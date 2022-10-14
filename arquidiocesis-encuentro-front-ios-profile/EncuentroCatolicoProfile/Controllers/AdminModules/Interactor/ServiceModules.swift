//
//  ServiceModules.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 25/06/21.
//

import Foundation


struct GetModulesData: ResponseDispatcher {
    typealias ResponseType = Modules
    var parameters: [String : Any]?
     var urlOptional: String?
    var id : String = ""
    var locatiosId: String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations/" + self.locatiosId + "/collaborators/" + self.id , method: .get, params: nil, url:Endpoints.urlGlobalApp)

          }
          
    init(id: String, locatiosId: String) {
        self.id = id
        self.locatiosId = locatiosId
       }
}

struct GetModulesLocationData: ResponseDispatcher {
    typealias ResponseType = [ModulesLocation]
    var parameters: [String : Any]?
    var urlOptional: String?
    var locatiosId: String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations/" + self.locatiosId + "/modules" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
        
    }
    
    init(locatiosId: String) {
        self.locatiosId = locatiosId
    }
}

struct ModelAddModules: Encodable {
    let module_id: [Int]
    
    var todiccionary : [[String: Any]]? {
        return [["module_id": self.module_id]]
    }

}

enum ServerErrors: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}
