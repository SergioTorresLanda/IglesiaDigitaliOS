//
//  DetailServicePresenter.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

class DetailServicePresenter: DetailServicePresenterProtocol, DetailServiceInteractorOutputProtocol {
    
    weak var view: DetailServiceViewProtocol?
    var interactor: DetailServiceInteractorInputProtocol?
    var wireFrame: DetailServiceWireFrameProtocol?

    init() {}
    
    func postBlessService(familyName: String, email: String, phone: String, description: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int) {
        interactor?.saveBlessService(familyName: familyName, email: email, phone: phone, description: description, zipcode: zipcode, neighborhood: neighborhood, longitude: longitude, latitude: latitude, location_id: location_id, service_id: service_id)
    }
    
    func postComuService(personName: String, email: String, phone: String, expanation: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int) {
        interactor?.saveComuService(personName: personName, email: email, phone: phone, expanation: expanation, zipcode: zipcode, neighborhood: neighborhood, longitude: longitude, latitude: latitude, location_id: location_id, service_id: service_id)
    }
    
    func responsePostServiceBless(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            view?.saveBlessError()
        case .ErrorServidor:
            view?.saveBlessError()
        case .OK:
            view?.saveBelssSucces()
        }
    }
    
    func responsePostServiceComu(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            view?.saveComuError()
        case .ErrorServidor:
            view?.saveComuError()
        case .OK:
            view?.saveComuSucces()
        }
    }
    
    func requestSububs(zipCode: String) {
        interactor?.getSuburb(zipCode: zipCode)
    }
    
    func getResponse(responseCode: HTTPURLResponse, responseData: DetailServiceEntity) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesRequestSububs(responseData: responseData)
                
            }else{
                self.view?.failRequestSububs()
                    
            }
        }
    }
    func goToMaps(isPrincipal: Int) {
        if let view = view {
            wireFrame?.pushToMap(fromView: view, isPrincipal: isPrincipal, mapType: "Soltero")
        }
    }
}
