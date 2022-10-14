//
//  ChurchsRemoteDataManager.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

final class ChurchsRemoteDataManager: ChurchsRemoteDataManagerType {
    private let networkingService: CancellableChurchsFetchable

    init(networkingService: CancellableChurchsFetchable = CancellableChurchsFetcher()) {
        self.networkingService = networkingService
    }

    func fetchChurchs(for query: String, completion: @escaping ([Church]) -> Void) {
        networkingService.fetchChurchs(withQuery: query, completion: completion)
    }
}
