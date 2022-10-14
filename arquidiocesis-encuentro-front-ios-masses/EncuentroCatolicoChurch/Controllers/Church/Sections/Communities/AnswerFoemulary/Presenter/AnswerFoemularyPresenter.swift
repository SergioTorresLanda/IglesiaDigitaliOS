//
//  AnswerFoemularyPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import Foundation

class AnswerFoemularyPresenter: AnswerFoemularyPresenterProtocol, AnswerFoemularyInteractorOutputProtocol {
    
    var view: AnswerFoemularyViewProtocol?
    
    var interactor: AnswerFoemularyInteractorInputProtocol?
    
    var wireFrame: AnswerFoemularyWireFrameProtocol?
    
    func callComunityType() {
        interactor?.getCommunityType()
    }
    
    func communityTypeResponse(response: CommunityTypeCatalog) {
        view?.communityTypeSuccess(response: response)
    }
    
    func communityTupeError(msg: String) {
        
    }
    
    func sendCommunityType(name: String, address: String, long: Double, lat: Double, email: String, phone: String, type: Int) {
        interactor?.postCommunity(name: name, address: address, long: long, lat: lat, email: email, phone: phone, type: type)
    }
    
    func responseAddCommunity(errores: ServerErrors, data: CommunityTypeModel?) {
        switch errores {
        case .ErrorInterno:
            view?.postAddCommunityFail(message: "\(errores.localizedDescription)")
        case .ErrorServidor:
            break
        case .OK:
            view?.postAddCommunitySuccess()
        }
    }
    
}
