//
//  UncionMapPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 20/07/21.
//

import UIKit

class UncionMapPresenter: UncionMapPresenterProtocol {
    
    weak private var view: UncionMapViewProtocol?
    var interactor: UncionMapInteractorProtocol?
    private let router: UncionMapRouterProtocol?
    
    init(interface: UncionMapViewProtocol, interactor: UncionMapInteractorProtocol, router: UncionMapRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}


