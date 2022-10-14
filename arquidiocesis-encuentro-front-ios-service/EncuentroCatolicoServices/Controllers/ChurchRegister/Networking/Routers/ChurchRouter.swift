//
//  ChurchRouter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 06/02/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import Alamofire

enum ChurchRouter: EnrutadorBase {
    
    case getChurches
    
    var method: HTTPMethod {
        switch self {
        case .getChurches:
            return .get
    
        }
    }
    
    var path: String {
        switch self {
        case .getChurches:
            return API.URLProvider.churches()
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
        }
    }
    
}
