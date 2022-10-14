//
//  LocationRouter.swift
//  EncuentroCatolicoUtils
//
//  Created by Miguel Eduardo  Valdez Tellez  on 19/04/21.
//

import Foundation
import Alamofire

struct LocationResponse: Codable {
    var id: UInt?
    var name: String?
    var image_url: String?
    var latitude: Double?
    var longitude: Double?
    var address: String?
}


enum LocationRouter: BaseRouter {
    
    case location
    
    var method: HTTPMethod {
        switch self {
        case .location:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .location:
            return API.URLProvider.locations()
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
        case .location:
            return nil
        }
    }
    
}
