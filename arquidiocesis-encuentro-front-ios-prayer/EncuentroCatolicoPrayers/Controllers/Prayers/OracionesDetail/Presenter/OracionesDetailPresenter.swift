//
//  OracionesDetailPresenter.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation


class OracionesDetailPresenter: PresenterOracionesDetailProtocol, InteractorOutputOracionesDetailProtocolo {
   
    
    var view: ViewOracionesDetailProtocol?
    
    var interactor: InteractorInputOracionesDetailProtocolo?
    
    var router: RouterOracionesDetailProtocol?
    
    func getDataInteractor(id: Int) {
        self.interactor?.getDetailData(id: id)
    }
    
    func getDataInteractorDevotions(id: Int) {
        self.interactor?.getDetailData(id: id)
    }
    
    func isSuccessServiceInteractor(data: DetailViewModel) {
        self.view?.isSuccess(data: data)
    }
    
    func isErrorService(msg: String) {
        self.view?.showError(message: msg)
    }
    
    
}
