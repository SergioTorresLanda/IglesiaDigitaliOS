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
    
    func requestLocations() {//Comunidades
        doGetLocations.init().execute { (result) in
            //print(result)
            self.presenter?.responseLocations(result: result)
        } onError: { error, msg in
            self.presenter?.errorGetLocations(msg: msg)
        }
    }
    
    func requestLocationsCom() {//Comunidades
        doGetLocationsCom.init().execute { (result) in
            //print(result)
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
        return RequestType(path: "/locations?type_location=CHURCH" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
        //return RequestType(path: "/locations" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
}

struct doGetLocationsCom: ResponseDispatcher {
    typealias ResponseType = [LocationResponse]
    var urlOptional: String?
    var parameters: [String : Any]?
    var data: RequestType {
        return RequestType(path: "/locations?type_location=COMMUNITY" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
        //return RequestType(path: "/locations" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
}
