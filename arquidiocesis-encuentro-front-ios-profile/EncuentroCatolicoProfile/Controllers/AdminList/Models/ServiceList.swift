//
//  ServiceList.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 25/06/21.
//

import Foundation

struct GetListData: ResponseDispatcher {
    typealias ResponseType = [UserList]
    var parameters: [String : Any]?
     var urlOptional: String?
    var id : String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations/" + self.id + "/collaborators"  , method: .get, params: nil, url:Endpoints.urlGlobalApp)

          }
          
    init(id: String) {
        self.id = id
       }
}

struct DoPersonSearchData: ResponseDispatcher {
    typealias ResponseType = [UserList]
    var parameters: [String : Any]?
     var urlOptional: String?
    var id : String = ""
    var name: String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations/" + self.id + "/collaborators?name=" + name  , method: .get, params: nil, url:Endpoints.urlGlobalApp)

          }
          
    init(id: String, name: String) {
        self.id = id
        self.name = name
       }
}
