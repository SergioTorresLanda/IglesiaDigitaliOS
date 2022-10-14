//
//  PrincipalPresenterSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class PrincipalPresenterSOS: PrincipalPresenterProtocol {
    
    weak private var view: PrincipalViewProtocol?
    var interactor: PrincipalInteractorProtocol?
    private let router: PrincipalRouterProtocol?
    
    init(interface: PrincipalViewProtocol, interactor: PrincipalInteractorProtocol, router: PrincipalRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getData() {
        interactor?.requestData()
    }
    
    func getResponse(data: [PModelSOS]) {
        DispatchQueue.main.async {
            self.view?.loadData(data: data)
        }
    }
    
    func getLastSOS(serviceID: Int) {
        interactor?.getLastSOS(serviceID: serviceID)
    }
    
    func onSuccessGetLastSOS(data: LastSosModel, response: HTTPURLResponse) {
        DispatchQueue.main.async {
            
            
            if response.statusCode == 200 {
                self.view?.successGetLastSOS(data: data)
            }else{
                self.view?.failGetLastSOS(message: "Error en la data")
            }
        }
    }
    
    func onFailGetLastSOS(error: Error) {
        print(error)
        self.view?.failGetLastSOS(message: error.localizedDescription)
    }
  
}
