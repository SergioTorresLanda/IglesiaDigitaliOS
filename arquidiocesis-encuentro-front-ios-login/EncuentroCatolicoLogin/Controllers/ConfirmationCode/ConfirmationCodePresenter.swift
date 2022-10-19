//
//  ConfirmationCodePresenter.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

class ConfirmationCodePresenter: ConfirmationCodePresenterProtocol {
    
    weak private var view: ConfirmationCodeViewProtocol?
    var interactor: ConfirmationCodeInteractorProtocol?
    private let router: ConfirmationCodeRouterProtocol?
    
    init(interface: ConfirmationCodeViewProtocol, interactor: ConfirmationCodeInteractorProtocol, router: ConfirmationCodeRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func postParamsChange(email: String, code: String, input: String) {
        interactor?.postParams(email: email, code: code, inputP: input)
    }
    
    func getStatusPost() {
        DispatchQueue.main.async {
            self.view?.succesChange()
        }
    }
    
    func getErrorPost() {
        DispatchQueue.main.async {
//            self.view?.errorChange()
        }
    }
    
    func postData2(dataEmail: String) {
        interactor?.postEmail2(email: dataEmail)
    }
    
    func getStatus2() {
        DispatchQueue.main.async {
            self.view?.statusResponse2()
        }
    }
    
    func requestUserInfo(email: String) {
        interactor?.getUserInfo(email: email)
    }
    
    func successUserInfo(data: UserInfo) {
        DispatchQueue.main.async {
            self.view?.succesUserInfo(data: data)
        }
        
    }
    
    func failUserInfo() {
        DispatchQueue.main.async {
            self.view?.failUserInfo()
        }
        
    }
    
}

