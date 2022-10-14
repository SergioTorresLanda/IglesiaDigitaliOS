//
//  ChurchRegisterPresenter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ChurchRegisterPresenter: ChurchRegisterPresenterProtocol, ChurchRegisterInteractorOutputProtocol {
    func goToChurchDetailMap(id: Int) {
        if let view = view {
            wireFrame?.pushChurchDetailMap(id: id, from: view)
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
}
