//
//  MapDonationsPresenter.swift
//  EncuentroCatolicoDonations
//
//

import Foundation

class MapDonationsPresenter: MapDonationsPresneterProtocol {
    weak private var view: MapDonationsViewProtocol?
    var interactor: MapDonationsInteractorProtocol?
    private let router: MapDonationsRouterProtocol?
    
    init (interface: MapDonationsViewProtocol, router: MapDonationsRouterProtocol, interactor: MapDonationsInteractorProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}
