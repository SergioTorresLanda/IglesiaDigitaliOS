//
//  ChurchPriestPresenter.swift
//  ChurchPriest_framework
//
//  Created by Ulises Atonatiuh González Hernández on 11/02/21.
//

import Foundation

class ChurchPriestPresenter: ChurchPriestPresenterProtocol, ChurchPriestInteractorOutputProtocol {
    
    weak var view: ChurchPriestViewProtocol?
    var interactor: ChurchPriestInteractorInputProtocol?
    var wireFrame: ChurchPriestWireFrameProtocol?
    

    func getDataInteractor(id: String, idChurch: String) {
        self.interactor?.getPriestDetail(idPriest: id, idChurch: idChurch)
    }
    
    func isErrorService(msg: String) {
        self.view?.showError(message: msg)
    }
    
   
    func isSuccessServiceInteractor(churchDetail: ChurchDetail?, servicesCatalog: Array<ServiceCatalogItem>?, massesCatalog: Array<MassesCatalogItem>?) {
       
        
//        let name = churchDetail?.nombre
//        let email = churchDetail?.email
//        let descr = churchDetail?.description
//        let img = churchDetail?.image
//        let addrChurch = churchDetail?.address
//        let nameChurch = churchDetail?.parson.name
//
//        let dates1: [String] =  churchDetail?.services.map ({ $0.day }) ?? []
//        let hours1: [String] = churchDetail?.services.map ({ $0.hours }) ?? []
//
//        let dates2: [String] = churchDetail?.masses.map ({ $0.days }) ?? []
//        let hours2: [String] = churchDetail?.masses.map ({ $0.hours }) ??  []
//        let phone: String = churchDetail?.phone ?? ""
//        let account: String = churchDetail?.bankAccount ?? ""


       // let data = ModelViewData(name: name, email: email, church: nameChurch, number: phone, welcomeDescription: descr, address: addrChurch, image: img, account: account, servicesHours: dates1, serviceHoursOficina: hours1, serviceDates: dates2, serviceDatesOficina: hours2)

        DispatchQueue.main.async {
            [weak self] in
           
            self?.view?.isSuccess(churchDetail: churchDetail,
                                  servicesCatalog: servicesCatalog,
                                  massesCatalog: massesCatalog)
        }
    }
    
    func updateChurchData(id: Int, _ data: ChurchEditionRequest) {
        interactor?.requestChurchDataUpdate(id: id, data)
    }
    
    func updateChurchResponse(response: ChurchEditionResponse?) {
        DispatchQueue.main.async {
            [weak self] in
            
            self?.view?.succesUpdate(response: response)
        }
    }
    
}
