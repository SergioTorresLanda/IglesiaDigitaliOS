//
//  CancellableChurchsFetcher.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

protocol CancellableChurchsFetchable {
    func fetchChurchs(withQuery query: String, completion: @escaping (([Church]) -> ()))
}

final class CancellableChurchsFetcher: CancellableChurchsFetchable {
    private var currentSearchNetworkTask: URLSessionDataTask?
    private let networkingService: NetworkingService
    
    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }
    
    func fetchChurchs(withQuery query: String, completion: @escaping (([Church]) -> ())) {
        currentSearchNetworkTask?.cancel() // cancel previous pending request
        
        _ = currentSearchNetworkTask = networkingService.searchChurchs(withQuery: query) { Churchs in
            completion(Churchs)
        }
    }
}
