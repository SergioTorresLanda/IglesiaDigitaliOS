//
//  ChurchRouter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 06/02/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import Alamofire

enum ChurchRouter: BaseRouter {
    
    case getChurches(id: Int)
    case getChurchDetail(id: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getChurches, .getChurchDetail:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getChurches(let id):
            return API.URLProvider.priestChurches(id: id)
        case .getChurchDetail(let id):
            return API.URLProvider.churchDetail(id: id)
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: Any? {
        return nil
    }
    
}
