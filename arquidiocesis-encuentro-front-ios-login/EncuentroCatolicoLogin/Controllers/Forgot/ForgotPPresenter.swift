//
//  ForgotPPresenter.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

class ForgotPPresenter: ForgotPresenterProtocol {
    
    weak private var view: ForgotViewProtocol?
    var interactor: ForgotInteractorProtocol?
    private let router: ForgotRouterProtocol?
    
    init(interface: ForgotViewProtocol, interactor: ForgotInteractorProtocol, router: ForgotRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func postData(dataEmail: String) {
        interactor?.postEmail(email: dataEmail)
    }
    
    func getStatus() {
        DispatchQueue.main.async {
            self.view?.statusResponse()
        }
    }
    
    func getStatus(status: HTTPURLResponse) {
        DispatchQueue.main.async {
            if status.statusCode == 200 {
                self.view?.statusResponse()
                
            }else{
                self.view?.failRequest()
                
            }
        }
    }
    
    
    
}
