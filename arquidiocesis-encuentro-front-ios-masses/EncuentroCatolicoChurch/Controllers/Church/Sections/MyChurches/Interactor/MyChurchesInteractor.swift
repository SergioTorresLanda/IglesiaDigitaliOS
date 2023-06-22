//
//  MyChurchesInteractor.swift
//  santander-kids
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class MyChurchesInteractor: MyChurchesInteractorInputProtocol {
    
    weak var presenter: MyChurchesInteractorOutputProtocol?

    init() {}
    
    //MARK: Networking
    func requestChurches(with id: Int) {
        DoCallChurches.init(id: String(id)).execute { (result) in
            self.presenter?.responseChurches(result: result)
        } onError: { (error, msg) in
            print("ERROR iglesias id::")
            print(id)
            self.presenter?.isError(msg: msg)
        }

    }
    
    func requestSearchBar(name: String) {
        
        let encodingName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        DoSearchBar.init(name: encodingName).execute { [weak self](result) in
            self?.presenter?.responseSearchBar(result: result)
            print(result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
            print(msg)
        }

    }
}

struct DoCallChurches: ResponseDispatcher {
    typealias ResponseType = PriestChurches
    var parameters: [String : Any]?
    var urlOptional: String?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/users/" + id + "/locations?category=CHURCH", method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}

struct DoSearchBar: ResponseDispatcher {
    typealias ResponseType = [Assigned]
    var parameters: [String : Any]?
    var urlOptional: String?
    var name: String = ""
    
    var data: RequestType {
        return RequestType(path: "/locations?name=" + name + "&type_location=CHURCH", method: .get, params: nil, url:Endpoints.urlSeacrh)
    }
          
    init(name: String) {
        self.name = name
    }
}


