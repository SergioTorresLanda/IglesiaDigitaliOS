//
//  MapDonationsPresenter.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 15/03/22.
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
