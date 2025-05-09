//
//  InitViewPresenter.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 14/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

public class InitViewPresenter: InitViewPresenterProtocol {

    weak private var view: InitViewViewProtocol?
    var interactor: InitViewInteractorProtocol?
    private let router: InitViewWireframeProtocol

    init(interface: InitViewViewProtocol, interactor: InitViewInteractorProtocol?, router: InitViewWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
