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
    
    private var churches: Array<Church> = Array()
    
    func getChurchesData(completion: @escaping (Array<Church>) -> Void) {
        if churches.isEmpty {
            
//            completion(Church.getDummyChurches())
            
            ManejadorDePeticiones.shared.perform(route: ChurchRouter.getChurches) {
                [weak self]
                (result: Result<Array<Church>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
                print(result)
                switch result {
                case .success(let response):
                    self?.churches = response
                    self?.fillNilData()
                    completion(response)
                case .failure:
                    completion(Array())
                }
            }
        } else {
            completion(churches)
        }
    }
    
    private func fillNilData() {
        DispatchQueue.global().async {
            [weak self] in
            var churchesFilled: Array<Church> = Array()
            self?.churches.forEach {
                church in
                var churchToFill = church
                churchToFill.services = Church.getDummyChurches().randomElement()?.services
                churchesFilled.append(churchToFill)
            }
            self?.churches = churchesFilled.sorted(by: { (first, second) -> Bool in
                return first.distanceInKm ?? 0 < second.distanceInKm ?? 0
            })
        }
    }
}
