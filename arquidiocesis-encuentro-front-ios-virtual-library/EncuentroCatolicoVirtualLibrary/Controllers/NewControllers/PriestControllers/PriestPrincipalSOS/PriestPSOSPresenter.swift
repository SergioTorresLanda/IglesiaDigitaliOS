//
//  PriestPSOSPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestPSOSPresenter: PriestPSOSPresenterProtocol {
    weak private var view: PriestPSOSViewProtocol?
    var interactor: PriestPSOSInteractorProtocol?
    private let router: PriestPSOSRouterProtocol?
    
    init(interface: PriestPSOSViewProtocol, interactor: PriestPSOSInteractorProtocol, router: PriestPSOSRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func requestListServices(paramStatus: String) {
        interactor?.getServicesList(paramStatus: paramStatus)
    }
    
    func transportResponseData(statusResponse: HTTPURLResponse, data: [ListSrevices]) {
        DispatchQueue.main.async {
            if statusResponse.statusCode == 200 {
                self.view?.successLoadRequestServices(requestData: data)
            }else{
                self.view?.failLoadRequestServices()
            }
        }
    }
    
}
