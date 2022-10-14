//
//  MassesPresenter.swift
//  EncuentroCatolicoMasses
//
//  Created Diego Martinez on 02/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MassesPresenter: MassesPresenterProtocol {

    weak private var view: MassesViewProtocol?
    var interactor: MassesInteractorProtocol?
    private let router: MassesWireframeProtocol

    init(interface: MassesViewProtocol, interactor: MassesInteractorProtocol?, router: MassesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
