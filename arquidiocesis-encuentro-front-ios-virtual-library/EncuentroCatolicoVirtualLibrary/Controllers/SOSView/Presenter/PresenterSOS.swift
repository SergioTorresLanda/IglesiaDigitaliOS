//
//  PresenterSOS.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation

class PresenterSOS: SOSPresenterProtocol, SOSInterctorOutputProtocol {
   
    
   
    
    var view: SOSViewProtocol?
    
    var interactor: SOSInterctorInputProtocol?
    
    var router: SOSRouterProtocol?
    
    func getData(id: UInt) {
        self.interactor?.requestInteractor(id: id)
    }
    
    func isError(msg: String) {
       
    }
    func responseError(msg: String) {
        self.view?.showError(msg)
    }
   
    
    func responseInteractor(result: [SOSFielModel]) {
        self.view?.showResult(result: result)
    }
    
}
