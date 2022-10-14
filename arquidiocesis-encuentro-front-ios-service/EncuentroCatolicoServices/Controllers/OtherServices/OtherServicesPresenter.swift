//
//  OtherServicesPresenter.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 22/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class OtherServicesPresenter: OtherServicesPresenterProtocol {

    weak private var view: OtherServicesViewProtocol?
    var interactor: OtherServicesInteractorProtocol?
    private let router: OtherServicesWireframeProtocol

    init(interface: OtherServicesViewProtocol, interactor: OtherServicesInteractorProtocol?, router: OtherServicesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getOptions(type: cases) {
        interactor?.requestServices(type: type)
    }
    
    func getResponse(errores: ServerErrors, data: [servicesSubOption], type: cases){
            DispatchQueue.main.async {
                switch errores {
                case .ErrorInterno:
                    let msg = ["titulo":"Error", "cuerpo": "Error en el servidor"]
                    self.view?.mostrarMSG(dtcAlerta: msg)
                case .ErrorServidor:
                    let msg = ["titulo":"Error", "cuerpo": "Error en la aplicación"]
                    self.view?.mostrarMSG(dtcAlerta: msg)
                case .OK:
                    self.view?.loadOptions(data: data, type: type)
                }
            }
    }

}
