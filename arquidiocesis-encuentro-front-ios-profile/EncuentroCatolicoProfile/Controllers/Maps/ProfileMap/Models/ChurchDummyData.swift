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
    private var coms: Array<LocationResponse> = Array()

    func getChurchesData(completion: @escaping (Array<LocationResponse>) -> Void) {
        if churches.isEmpty {
            print("Churches empty")
//            completion(Church.getDummyChurches())
            
            RequestManager.shared.perform(route: LocationRouter.location) {
                [weak self]
                (result: Result<Array<LocationResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
                switch result {
                case .success(let response):
                    self?.churches = response
                    print("Churches SUCCESS: ")
                    //print(response)
                    completion(response)
                case .failure:
                    print("Churches FAIL: ")
                    completion(Array())
                }
            }
        } else {
            print("Churches NOT empty")
            completion(churches)
        }
    }
    
    func getComsData(completion: @escaping (Array<LocationResponse>) -> Void) {
        if coms.isEmpty {
            print("Coms empty")
//            completion(Church.getDummyChurches())
            RequestManager.shared.perform(route: LocationRouter.locationCom) {
                [weak self]
                (result: Result<Array<LocationResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
                switch result {
                case .success(let response):
                    self?.coms = response
                    print("Coms SUCCESS: ")
                    //print(response)
                    completion(response)
                case .failure:
                    print("Coms FAIL: ")
                    completion(Array())
                }
            }
        } else {
            print("Coms NOT empty")
            completion(coms)
        }
    }
}
