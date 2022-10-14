//
//  ChurchRegisterPresenter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ChurchRegisterPresenter: ChurchRegisterPresenterProtocol, ChurchRegisterInteractorOutputProtocol {
    
    func goToCommunityDetail(id: Int, myChourch: Bool, isPricipalBool: Bool) {
        if let view = view {
            wireFrame?.pushCommunityDetail(id: id, from: view, myChourch: myChourch, isPricipalBool: isPricipalBool)
        }
    }
    
    func goToChurchDetailMap(id: Int, selector: Int) {
        if let view = view {
            wireFrame?.pushChurchDetailMap(id: id, from: view, selector: selector)
        }
    }
    
    weak var view: ChurchRegisterViewProtocol?
    var interactor: ChurchRegisterInteractorInputProtocol?
    var wireFrame: ChurchRegisterWireFrameProtocol?
    init() {}
    
    func getLocations() {
        interactor?.requestLocations()
    }
    
    func responseLocations(result: Result<Array<LocationResponse>,ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showLocation(location: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
        }
    }
    
    func getCommunityDetailMap(lat: Double, lon: Double) {
        interactor?.requestCommunityLocations(lat: lat, long: lon)
    }
    
    func responseCommunityLocations(response: CommunityLocationList) {
        view?.communityLocationSuccess(response: response)
    }
    
    func errorCommunityLocation(msg: String) {
        view?.communityLocationError(msg: msg)
    }
}
