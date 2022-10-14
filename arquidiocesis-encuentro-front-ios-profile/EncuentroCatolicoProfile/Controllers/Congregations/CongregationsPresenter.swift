//
//  CongregationsPresenter.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation
import UIKit

class CongregationsPresenter: CongregationsPresenterProtocol {
    weak private var view: CongregationsViewProtocol?
    var interactor: CongregationsInteractorProtocol?
    private let router: CongregationsRouterProtocol?
    
    init(interface: CongregationsViewProtocol, interactor: CongregationsInteractorProtocol, router: CongregationsRouterProtocol) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestListCongregations() {
        interactor?.getCongregations()
    }
    
    func transportSuccesDataResponse(data: CongregationsList) {
        DispatchQueue.main.async {
            self.view?.succesResponse(data: data)
        }
    }
    
    func transportFailDataResponse() {
        DispatchQueue.main.async {
            self.view?.failResponse()
        }
    }
    
}
