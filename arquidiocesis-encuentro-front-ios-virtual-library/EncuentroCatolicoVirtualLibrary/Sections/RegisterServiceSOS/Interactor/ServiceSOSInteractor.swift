//
//  ServiceSOSInteractor.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import Foundation

final class ServiceSOSInteractor: ServiceSOSInteractorInputsType {

    weak var presenter: ServiceSOSInteractorOutputsType?

    // Dependencies
    private let dataManager: ServicesSOSRemoteDataManager

    init(dataManager: ServicesSOSRemoteDataManager = ServicesSOSRemoteDataManager()) {
        self.dataManager = dataManager
    }

    func registerServices(parameters: [String : Any?]) {
        dataManager.registerService(withParameters: parameters, completion: { [weak self] status in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRegisterServicesSuccess(status)
        })
    }
}
