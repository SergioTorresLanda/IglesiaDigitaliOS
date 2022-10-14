//
//  ListServicesPresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class ListServicePresenter: ListServicePresenterProtocol {
    
    weak private var view: ListServiceViewProtocol?
    var interactor: ListServiceInteractorProtocol?
    private let router: ListServiceRouterProtocol?
    
    init(interface: ListServiceViewProtocol, interactor: ListServiceInteractorProtocol, router: ListServiceRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
// MARK: LIST REQUEST FUNCTIONS -
    func callInterGetList(isHistorial: String, role: String) {
        interactor?.getListServices(queryParam: isHistorial, xrole: role)
    }
    
    func passResponseRequestList(responseData: [ListServicesStandard], codeResponse: HTTPURLResponse) {
        DispatchQueue.main.async {
            if codeResponse.statusCode == 200 {
                self.view?.successRequestList(data: responseData)
            }else{
                self.view?.failRequestList()
            }
        }
        
    }
    
// MARK: DELETE REQUEST FUNCTIONS -
    func makeDelete(servieID: String) {
        interactor?.deleteService(idService: servieID)
    }
    
    func deleteResponse(responseCode: HTTPURLResponse) {
        print("****\(responseCode)")
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesDeleteRequest()
            }else{
                self.view?.failDeleteRequest()
            }
        }
    }
    
    func fatalErrorDelete() {
        self.view?.fatalErroDelteRequest()
    }
    
}
