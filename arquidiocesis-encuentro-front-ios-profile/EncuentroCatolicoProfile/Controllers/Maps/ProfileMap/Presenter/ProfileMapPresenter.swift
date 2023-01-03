//
//  ProfileMapPresenter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ProfileMapPresenter: ProfileMapPresenterProtocol, ProfileMapInteractorOutputProtocol {
    
    func goToChurchDetailMap(id: Int, selector: Int) {
        if let view = view {
            print("Es view")
            wireFrame?.pushChurchDetailMap(id: id, from: view, selector: selector)
        }
    }
    
    func dismissMapModule(id: Int, name: String, url: String, from: AnyObject) {
        wireFrame?.pushChurchDetailMap(id: id, from: from, selector: 0)
    }
    
    var view: ProfileMapViewProtocol?
    var interactor: ProfileMapInteractorInputProtocol?
    var wireFrame: ProfileMapWireFrameProtocol?
    
    
    func getLocations() {//Comunidades
        interactor?.requestLocations()
    }
    func getLocationsCom() {//Comunidades
        interactor?.requestLocationsCom()
    }
    
    func responseLocations(result: [LocationResponse]) {
        view?.showLocation(location: result)
    }
    
    func errorGetLocations(msg: String) {
        view?.showError(error: msg)
    }
}
