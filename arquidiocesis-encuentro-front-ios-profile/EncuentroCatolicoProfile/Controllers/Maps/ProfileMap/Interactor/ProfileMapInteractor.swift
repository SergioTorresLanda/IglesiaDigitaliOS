//
//  ProfileMapInteractor.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ProfileMapInteractor: ProfileMapInteractorInputProtocol {
    
    weak var presenter: ProfileMapInteractorOutputProtocol?
    
    func requestLocations() {
        doGetLocations.init().execute { (result) in
            self.presenter?.responseLocations(result: result)
        } onError: { error, msg in
            self.presenter?.errorGetLocations(msg: msg)
        }
    }
}

struct doGetLocations: ResponseDispatcher {
    typealias ResponseType = [LocationResponse]
    var urlOptional: String?
    var parameters: [String : Any]?
    var data: RequestType {
        return RequestType(path: "/locations" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
}
