//
//  OracionesPresenter.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//

import Foundation

class OracionesPresenter: PresenterOracionesProtocol, InteractorOutputOracionesProtocolo {
   
    
     var view: ViewOracionesProtocol?
    
    var interactor: InteractorInputOracionesProtocolo?
    
    var router: RouterOracionesProtocol?
    init() {
    }

    func getDataInteractor(name: String) {
        self.interactor?.getOracion(name: name)
    }
    
    func getDataInteractorSearchBar(type: String) {
        var search = type.lowercased()
        search = search.replacingOccurrences(of: "oracion", with: "oración")
        print("Buscar \(search)")
        self.interactor?.getOracionSearchBar(type: search)
    }
    
    func isSuccessServiceInteractor(data: [DataResponse]) {
        self.view?.isSuccess(data: data)
    }
    
    func isErrorService(msg: String) {
        self.view?.showError(message: msg)
    }
    
    
}
