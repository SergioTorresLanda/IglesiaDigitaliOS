//
//  UserRouter.swift
//  encuentro
//
//  Created by Ahmed Castro on 10/3/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import Alamofire

struct UserRequest: Codable {
    var username: String
    var phone: String
}

struct UserResponse: Codable {
    var user_id: String?
    var confirmation_code: String?
    var success : Bool
    var message: String
}

enum UserRouter: EnrutadorBase {
    
    case registry(request: UserRequest)
    
    var method: HTTPMethod {
        switch self {
        case .registry:
            return .POST
    
        }
    }
    
    var path: String {
        switch self {
        case .registry:
            return API.URLProvider.urlInicioDeSesion()
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
        case .registry(let request):
            return request
        }
    }
    
}
