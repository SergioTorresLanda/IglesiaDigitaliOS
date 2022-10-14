//
//  ChurchRegisterInteractor.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ChurchRegisterInteractor: ChurchRegisterInteractorInputProtocol {
    func requestLocations() {
        RequestManager.shared.perform(route: LocationRouter.location) { [weak self] (result: Result<Array<LocationResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseLocations(result: result)
        }
    }
    
  
    weak var presenter: ChurchRegisterInteractorOutputProtocol?

    init() {}
}
