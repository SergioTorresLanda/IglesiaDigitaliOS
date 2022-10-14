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
        
        static let newHost = "https://rc1hfd6cjd.execute-api.us-east-1.amazonaws.com/dev/v3"
        static let testHost = "https://api-develop.arquidiocesis.mx"
        #endif
        
        struct EndPoint {
            static let registrer = "user/registry"
            static let churches = "https://zoh3vla2n7.execute-api.us-east-1.amazonaws.com/default/ms-church-service/churchs"
            static let locations = "/locations"
        }
        
        static func urlInicioDeSesion() -> String {
            return host + version + EndPoint.registrer
        }
        
        static func churches() -> String {
            return EndPoint.churches
        }
        
        static func locations() -> String {
            return testHost + EndPoint.locations
        }
        
        
    }
}

