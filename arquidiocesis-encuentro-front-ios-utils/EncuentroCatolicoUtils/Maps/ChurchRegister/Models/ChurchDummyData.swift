//
//  ChurchDummyData.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 06/02/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

class DummyData {
    
    static let shared = DummyData()
    private init(){}
    
    private var churches: Array<LocationResponse> = Array()
    
    func getChurchesData(completion: @escaping (Array<LocationResponse>) -> Void) {
        if churches.isEmpty {
            
//            completion(Church.getDummyChurches())
            
            RequestManager.shared.perform(route: LocationRouter.location) {
                [weak self]
                (result: Result<Array<LocationResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
                switch result {
                case .success(let response):
                    self?.churches = response
                    completion(response)
                case .failure:
                    completion(Array())
                }
            }
        } else {
            completion(churches)
        }
    }
}
