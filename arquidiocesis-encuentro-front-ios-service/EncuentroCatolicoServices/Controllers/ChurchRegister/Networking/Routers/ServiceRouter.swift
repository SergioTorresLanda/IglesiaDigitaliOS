//
//  ServicesRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Miguel Eduardo  Valdez Tellez  on 26/04/21.
//

import Foundation
import Alamofire


struct ServicesPost: Codable {
    let devotee: Devotee?
    let service: Service?
    let priest: Priest?
    let location: Location?
    let longitude, latitude: Int?
}

struct Devotee: Codable {
    let devotee_id: Int?
    let phone, name, email: String?
}

struct Service: Codable {
    let id: Int?
    let type: String?
}

struct Priest: Codable {
    let priest_id: String?
}

struct Location: Codable {
    let id: Int?
}

struct ResponseOtherService: Codable {}


enum ServiceRouter: EnrutadorBase {
    
    case getChurches
    case postServices(request: ServicesPost)
    
    var method: HTTPMethod {
        switch self {
        case .getChurches:
            return .get
        case .postServices:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getChurches:
            return API.URLProvider.churches()
        case .postServices:
            return API.URLProvider.requestOtherServices()
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: Any? {
        switch self {
        case .getChurches:
            return nil
        case .postServices(request: let request):
            return request
        }
    }

}

    
