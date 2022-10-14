//
//  CancellableServiceSOSFetcher.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import Foundation


protocol CancellableServicesRegistrable {
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void)
}

final class CancellableServicesRecorder: CancellableServicesRegistrable {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }

    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void) {
        currentSearchNetworkTask?.cancel()
        
        _ = currentSearchNetworkTask = networkingService.registerService(withParameters: parameters) { status in
            completion(status == .succeed)
        }
    }
}
