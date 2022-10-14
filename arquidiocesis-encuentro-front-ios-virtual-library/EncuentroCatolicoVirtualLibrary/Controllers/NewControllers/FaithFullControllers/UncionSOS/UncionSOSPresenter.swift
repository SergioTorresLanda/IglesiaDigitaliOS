//
//  UncionSOSPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class UncionSOSPresenter: UncionPresenterProtocol {
    
    weak private var view: UncionViewProtocol?
    var interactor: UncionInteractorProtocol?
    private let router: UncionRouterProtocol?
    private var locations = [LocationSOS]()
    
    init(interface: UncionViewProtocol, interactor: UncionInteractorProtocol, router: UncionRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getRequestChurchesList(lat: String, long: String) {
        interactor?.getListChurches(latitude: lat, longitude: long)
    }
    
    func transportData(responseStatus: HTTPURLResponse, data: [ListChurches]) {
        DispatchQueue.main.async {
            if responseStatus.statusCode == 200 {
                self.view?.loadRequestData(data: data)
            }else{
                
            }
        }
        
    }
    
    func postCreateService(address: String, latitude: Double, longitude: Double, devoteeID: Int, idService: Int, contactID: Int) {
        interactor?.postService(address: address, latitude: latitude, longitude: longitude, devoteeID: devoteeID, idService: idService, contactID: contactID)
    }
    
    func getPostReponse(responseCode: HTTPURLResponse, responseData: ServiceResponse) {
        DispatchQueue.main.async {
            print(responseCode)
            if responseCode.statusCode == 201 {
                self.view?.successCreateService(data: responseData)
            }else{
                
            }
            
        }
    }
    
}

