//
//  ChurchsInteractor.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

final class ChurchsInteractor: ChurchsInteractorInputsType {
    weak var presenter: ChurchsInteractorOutputsType?

    // Dependencies
    private let dataManager: ChurchsRemoteDataManager
    private let validator = ThrottledTextFieldValidator()

    init(dataManager: ChurchsRemoteDataManager = ChurchsRemoteDataManager()) {
        self.dataManager = dataManager
    }

    // ChurchsInteractorInputsProtocol
    func fetchChurchs(for query: String) {
        if query.isEmpty {
            startFetching(for: "")
        } else {
            validator.validate(query: query) { [weak self] query in
                guard let strongSelf = self,
                      let query = query else { return }
                strongSelf.startFetching(for: query)
            }
        }
    }

    func fetchInitialChurchs() {
        startFetching(for: "")
    }

    private func startFetching(for query: String) {
        dataManager.fetchChurchs(for: query, completion: { [weak self] Churchs in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveChurchs(Churchs)
        })
    }
}
