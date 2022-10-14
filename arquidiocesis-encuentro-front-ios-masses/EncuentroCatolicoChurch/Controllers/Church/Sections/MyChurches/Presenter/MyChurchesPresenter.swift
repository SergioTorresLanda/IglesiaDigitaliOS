//
//  MyChurchesPresenter.swift
//  santander-kids
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class MyChurchesPresenter: MyChurchesPresenterProtocol, MyChurchesInteractorOutputProtocol {
    
    
    
    weak var view: MyChurchesViewProtocol?
    var interactor: MyChurchesInteractorInputProtocol?
    var wireFrame: MyChurchesWireFrameProtocol?

    init() {}
    
    
    //MARK: Interactor
    func getChurches(with id: Int) {
        interactor?.requestChurches(with: id)
    }
    
    //MARK: View
    func responseChurches(result: PriestChurches) {
        self.view?.showChurches(result)
    }
    
    func searchBarChurch(name: String) {
        self.interactor?.requestSearchBar(name: name)
    }
    
    func responseSearchBar(result: [Assigned]) {
        self.view?.showSearchBarResponse(result: result)
    }
    
    func isError(error: String) {
        
    }
    
    func isError(msg: String) {
        self.view?.showError(msg)
    }
    
    
    //MARK: Wireframe
    func goToChurchDetail(id: Int, selector: Int) {
        if let view = view {
            wireFrame?.pushChurchDetail(id: id, from: view, selector: selector)
        }
    }
    func goToChourchMap(id: Int, selector: Int) {
        if let view = view {
            wireFrame?.pushChurchMap(id: id, from: view, selector: selector)
        }
    }
}
