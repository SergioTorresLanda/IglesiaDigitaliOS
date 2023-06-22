//
//  ChurchDetailPresenter.swift
//  Encuentro
//
//  Created by Edgar Hernandez Solis on 02/12/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

class ChurchDetailPresenter: ChurchDetailPresenterProtocol, ChurchDetailInteractorOutputProtocol {
    
    weak var view: ChurchDetailViewProtocol?
    var interactor: ChurchDetailInteractorInputProtocol?
    var wireFrame: ChurchDetailWireFrameProtocol?

    init() {}
    
    //MARK: Interactor
    func getDetail(id: Int) {
        interactor?.requestDetail(id: id)
    }
    
    //MARK: View
    func responseDetail(result: ChurchDetail) {
        view?.showDetail(church: result)
    }
    
    func errorDetail(msg: String) {
        view?.showError("Error al cargar detalle de iglesia: "+msg)
    }
    
    
    //MARK: Wireframe
    func goToEdition(id: Int, churchDetail: ChurchDetail) {
        if let view = view {
            wireFrame?.pushEdition(id: id, from: view, churchDetail: churchDetail)
        }
    }
    func goToMyChourch() {
        if let view = view {
            wireFrame?.presentMyChurchesModule(fromView: view)
        }
        
    }
    
    func saveFavorite(id: Int, idPriest: Int, isPrincipal: Int) {
        self.interactor?.requestAddFavorite(id: id, idPriest: idPriest, isPrincipal: isPrincipal)
    }
    
    func removeFavorite(id: Int, idPriest: Int, isPrincipal: Int) {
        self.interactor?.requestRemoveFavorite(id: id, idPriest: idPriest, isPrincipal: isPrincipal)
    }
    
    func responseFavorite(errores: ServerErrors, data: [ModelResponseAddFav]) {
        switch errores {
        case .ErrorInterno:
            print("Error Interno")
        case .ErrorServidor:
            print("Error Servidor")
        case .OK:
            self.view?.updateDeleteImage()
            self.view?.isCorrectFavorite()
        }
    }
    
    func responseRemoveFavorite(errores: ServerErrors, data: [ModelResponseRemoveFavorites]) {
        switch errores {
        case .ErrorInterno:
            print("Error Interno")
        case .ErrorServidor:
            print("Error Servidor")
        case .OK:
            self.view?.updateFavImage()
            self.view?.isCorrectFavorite()
        }
    }
    
    
    func saveChurch(idLocation: Int, idPriest: Int) {
        self.interactor?.requestAddFavoriteSacerdote(idLocation: idLocation, idPriest: idPriest)
    }
    
    func removeChurch(idLocation: Int, idPriest: Int) {
        self.interactor?.requestRemoveChurchSacerdote(idLocation: idLocation, idPriest: idPriest)
    }
    
    func responseAddChurchSacerdote(msg: String?) {
        if msg == nil {
            self.view?.isCorrectFavorite()
        } else {
            self.view?.showError(msg ?? "")
        }
    }
    
    func responseRemoveChurchSacerdote(msg: String?) {
        if msg == nil {
            self.view?.isCorrectFavorite()
        } else {
            self.view?.showError(msg ?? "")
        }
    }
    
    func putChurchEdition(locationId: Int, description: String, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, bankAcount: String, principal: Int, schedules: [AttentionEditChurch], attention: [AttentionEditChurch], masses: [MassEditChurch], services: [ServiceEditChurch]) {
        interactor?.saveChurchEdition(locationId: locationId, description: description, email: email, phone: phone, website: website, instagram: instagram, twitter: twitter, facebook: facebook, streaming: streaming, bankAcount: bankAcount, principal: principal, schedules: schedules, attention: attention, masses: masses, services: services)
    }
    
    func responsePutEditChurch(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            view?.saveChurchError()
        case .ErrorServidor:
            view?.saveChurchError()
        case .OK:
            view?.saveChurchSucces()
        }
    }
    func getServiceCatalog() {
        interactor?.requestServiceCatalog()
    }
    
    func responseGetServiceCatalog(data: ServiceCatalogModel) {
        view?.serviceCatalogSuccess(response: data)
    }
    
    func errorGetServiceCatalog(msg: String) {
        view?.serviceCatalogError()
    }
    
    func requestListComments(queryParams: String) {
        interactor?.getCommentsList(queryParam: queryParams)
    }
    
    func transportResponseCommentsList(contentData: Comments) {
        DispatchQueue.main.async {
            self.view?.successRequestComments(data: contentData)
        }
       
    }
    
    func errorTransportCommentList(responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            self.view?.failRequestComments()
        }
       
    }
    
}
