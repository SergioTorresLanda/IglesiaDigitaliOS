//
//  ChurchRegisterInteractor.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ChurchRegisterInteractor: ChurchRegisterInteractorInputProtocol {
    func requestCommunityLocations(lat: Double, long: Double) {
        doGetLocationDetail.init(lat: lat, long: long).execute { (result) in
            self.presenter?.responseCommunityLocations(response: result)
        } onError: { (error, msg) in
            self.presenter?.errorCommunityLocation(msg: msg)
        }
    }
    
    func requestLocations() {
        RequestManager.shared.perform(route: LocationRouter.location) { [weak self] (result: Result<Array<LocationResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseLocations(result: result)
        }
    }
    
  
    weak var presenter: ChurchRegisterInteractorOutputProtocol?

    init() {}
}

struct doGetLocationDetail: ResponseDispatcher {
    
    typealias ResponseType = CommunityLocationList
    var urlOptional: String?
    var parameters: [String : Any]?
    var lat: Double = 0.0
    var long: Double = 0.0
    
    var data: RequestType {
        return RequestType(path: "/locations?type_location=COMMUNITY&latitude=" + String(lat) + "&longitude=" + String(long) , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
}
