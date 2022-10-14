//
//  NewHomeServicePresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class NewHomeServicePresenter: NewHomeServicePresenterProtocol {
    weak private var view: NewHomeServiceViewProtocol?
    var interactor: NewHomeServiceInteractorProtocol?
    private let router: NewHomeServiceRouterProtocol?
    
    init(interface: NewHomeServiceViewProtocol, interactor: NewHomeServiceInteractorProtocol, router: NewHomeServiceRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}
