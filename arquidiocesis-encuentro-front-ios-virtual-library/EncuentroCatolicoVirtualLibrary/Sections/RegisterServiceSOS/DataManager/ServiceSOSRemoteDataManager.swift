//
//  ServiceSOSRemoteDataManager.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import Foundation

final class ServicesSOSRemoteDataManager: ServiceSOSRemoteDataManagerType {
    private let networkingService: CancellableServicesRecorder

    init(networkingService: CancellableServicesRecorder = CancellableServicesRecorder()) {
        self.networkingService = networkingService
    }

    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void) {
        networkingService.registerService(withParameters: parameters, completion: completion)
    }
}
