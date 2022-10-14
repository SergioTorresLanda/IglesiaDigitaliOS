//
//  API.swift
//  CetesDirecto
//
//  Created by Edgar Hernandez on 6/4/19.
//  Copyright © 2019 Linko. All rights reserved.
//

import Foundation

struct API {
    
    static private var version = "/v1/"
   
    struct URLProvider {
        
        #if PROD
        static let host = "https://gdagkada09.execute-api.us-east-1.amazonaws.com"
        #elseif QA
        static let host = "https://gdagkada09.execute-api.us-east-1.amazonaws.com"
        #else
        static let host = "https://gdagkada09.execute-api.us-east-1.amazonaws.com"
        static let hostService = "\(APIType.shared.User())/"
        #endif
        
        struct EndPoint {
            static let services = "/services"
            static let registrer = "user/registry"
            static let churches = "\(APIType.shared.User())/locations?type_location=CHURCH"
        }
        
        static func urlInicioDeSesion() -> String {
            return host + version + EndPoint.registrer
        }
        
        static func churches() -> String {
            return EndPoint.churches
        }
        
        static func requestOtherServices() -> String {
            return hostService + EndPoint.services
        }
        
    }
}

