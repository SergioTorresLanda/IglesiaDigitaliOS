//
//  MyCommunitiesMainViewInteractor.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 12/08/21.
//

import Foundation

class MyCommunitiesMainViewInteractor: MyCommunitiesMainViewInteractorInputProtocol {
    
    var presenter: MyCommunitiesMainViewInteractorOutputProtocol?
    
    func getCommunities(id: Int) {
        doGetCommunitiesMain.init(id: String(id)).execute { (result) in
            self.presenter?.communitiesResponse(response: result)
        } onError: { (error, msg) in
            self.presenter?.communitiesError(msg: msg)
        }
    }
    
    func requestSearchBar(name: String) {
        DoComSearchBar.init(name: name).execute { (result) in
            self.presenter?.responseSearchBar(result: result)
        } onError: { (error, msg) in
            self.presenter?.communitiesError(msg: msg)
        }
    }
    
}

struct doGetCommunitiesMain: ResponseDispatcher {
    
    typealias ResponseType = CommunityMainList
    var urlOptional: String?
    var parameters: [String : Any]?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/users/" + id + "/locations?category=COMMUNITY" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}

struct DoComSearchBar: ResponseDispatcher {
    typealias ResponseType = CommunitySearchList
    var parameters: [String : Any]?
     var urlOptional: String?
    var name: String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations?type_location=COMMUNITY&name=" + name , method: .get, params: nil, url:Endpoints.urlSeacrh)
          }
          
    init(name: String) {
        self.name = name
       }
}
