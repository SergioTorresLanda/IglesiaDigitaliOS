//
//  IntentionsPresenter.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 27/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class IntentionsPresenter: IntentionsPresenterProtocol {
    
    weak private var view: IntentionsViewProtocol?
    var interactor: IntentionsInteractorProtocol?
    private let router: IntentionsWireframeProtocol

    init(interface: IntentionsViewProtocol, interactor: IntentionsInteractorProtocol?, router: IntentionsWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestlocations() {
        interactor?.requestlocations()
    }
    
    func getResponse(errores: ServerErrors, data: PriestChurches?) {
        DispatchQueue.main.async {
            switch errores {
            case .ErrorInterno:
                // let msg = ["titulo":"Error", "cuerpo": "Error en el servidor"]
                //                self.view?.mostrarMSG(dtcAlerta: msg)
                break
            case .ErrorServidor:
                //let msg = ["titulo":"Error", "cuerpo": "Error en la aplicación"]
                //                self.view?.mostrarMSG(dtcAlerta: msg)
                break
            case .OK:
                guard let data = data else {
                    return
                }
                self.view?.loadOptions(data: data)
            }
        }
    }
    func searchBarIntentionsChurch(name: String) {
        interactor?.requestSearchBar(name: name)
    }
    
    func responseSearchBar(errores: ServerErrors, result: [Assigned]) {
        switch errores {
        case .ErrorInterno:
            print("Error Interno")
        case .ErrorServidor:
            print("Error Servidor")
        case .OK:
            view?.showSearchBarResponse(result: result)
        }
    }
}
