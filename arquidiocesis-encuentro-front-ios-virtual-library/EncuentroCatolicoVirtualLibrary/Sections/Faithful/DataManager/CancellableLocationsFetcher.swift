//
//  CancellableChurchsFetcher.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

protocol CancellableLocationsFetchable {
    func fetchLocations(withQuery query: String, completion: @escaping (([LocationSOS]) -> Void))
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void)
}

final class CancellableLocationsFetcher: CancellableLocationsFetchable {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService

    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }

    func fetchLocations(withQuery query: String, completion: @escaping (([LocationSOS]) -> Void)) {
        currentSearchNetworkTask?.cancel() // cancel previous pending request

        _ = currentSearchNetworkTask = networkingService.getLocations(withQuery: query) { Locations in
            completion(Locations)
        }
    }
    
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void) {
        currentSearchNetworkTask?.cancel()
        
        _ = currentSearchNetworkTask = networkingService.registerService(withParameters: parameters) { status in
            completion(status == .succeed)
        }
    }
}
