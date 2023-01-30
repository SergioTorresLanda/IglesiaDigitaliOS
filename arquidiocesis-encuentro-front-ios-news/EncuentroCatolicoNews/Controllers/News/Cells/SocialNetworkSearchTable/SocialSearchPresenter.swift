//
//  SocialSearchPresenter.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation
import UIKit

class SocialSearchPresenter: SocialSearchPresenterProtocol {
    weak private var view: SocialSearchViewProtocol?
    var interactor : SocialSearchInteractorProtocol?
    private let router : SocialSearchRouterProtocol?
    
    init(interface: SocialSearchViewProtocol, interactor: SocialSearchInteractorProtocol, router: SocialSearchRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
// MARK: SERACH FUNCTIONS -
    func requestSearch(searchText: String) {
        interactor?.getSearch(searchText: searchText)
    }
    
    func onSuccessRequestSearch(data: SerachResponse, reponse: HTTPURLResponse) {
        DispatchQueue.main.async {
            if reponse.statusCode == 200 {
                self.view?.successSearch(data: data)
            }else{
                self.view?.failSearch(message: "Error generico")
            }
        }
    }
    
    func onFailRequestSearch(error: Error) {
        self.view?.failSearch(message: error.localizedDescription)
    }
    
// MARK: FOLLOW FUNCTIONS -
    
    func requestFollowUF(method: String, entityId: Int, entityType: Int) {
        interactor?.followAndFollowUF(method: method, entityId: entityId, entityType: entityType)
    }
    
    func onSuccessRequestFollowUF(data: FollowResponse, response: HTTPURLResponse) {
        print("FUNCION PARA DEJAR DE SEGUIR")
        print(data)
        print(response)
        
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.successFollowUF(data: data)
            }else{
                self.view?.failFollowUF(message: "Error generico")
            }
        }
    }
    
    func onFailRequestFollowUF(error: Error) {
        DispatchQueue.main.async {
            self.view?.failFollowUF(message: error.localizedDescription)
        }
    }
    
}
