//
//  PriestDetailPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

class PriestDetailPresenter: PriestDetailPresenterPRotocol {
    
    weak private var view: PriestDetailViewProtocol?
    var interactor: PriestDetailInteractorProtocol?
    private let router: PriestDetailRouterProtocol?
    
    init(interface: PriestDetailViewProtocol, interactor: PriestDetailInteractorProtocol, router: PriestDetailRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func requestDetailService(idService: Int) {
        interactor?.getServiceDetail(idService: idService)
    }
    
    func TransportaData(responseCode: HTTPURLResponse, data: PriestDetail) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesRequest(data: data)
            }else{
                self.view?.failRequest()
            }
        }
    }
    
}
