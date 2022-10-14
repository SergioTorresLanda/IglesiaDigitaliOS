//
//  ChurchsRemoteDataManager.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

final class LocationsRemoteDataManager: LocationsRemoteDataManagerType {
    private let networkingService: CancellableLocationsFetchable

    init(networkingService: CancellableLocationsFetchable = CancellableLocationsFetcher()) {
        self.networkingService = networkingService
    }

    func getLocations(for query: String, completion: @escaping ([LocationSOS]) -> Void) {
        networkingService.fetchLocations(withQuery: query, completion: completion)
    }

    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void) {
        networkingService.registerService(withParameters: parameters, completion: completion)
    }
}
