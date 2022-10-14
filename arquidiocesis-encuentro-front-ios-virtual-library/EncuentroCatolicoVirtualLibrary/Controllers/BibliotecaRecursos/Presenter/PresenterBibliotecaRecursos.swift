//
//  PresenterBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation


class BibliotecaRecursosPresenter: BibliotecaRecursosPresenterProtocol , BibliotecaRecursosOutputInteractorProtocol {
  
    var view: BibliotecaRecursosViewProtocol?
    
    var interactor: BibliotecaRecursosInputInteractorProtocol?
    
    var router: BibliotecaRecursosRouterProtocol?
    
    
    func getDataHome() {
        self.interactor?.requestInteractorDataHome()
    }
    
    func getDataSearch(text: String) {
        self.interactor?.requestInteractorDataSeacrh(text: text)
    }
    
    func responseInteractorDataHome(result: LibraryResourcesResponse) {
        self.view?.showResult(result: result)
    }
    
    func responseInteractorDataSearch(result: [LibrarySearchResponse]) {
        self.view?.showResultSearch(result: result)
    }
    
    func isErrorServer(msg: String) {
        self.view?.showError(msg)
    }
    
   
   
    func isError(msg: String) {
        
    }
    
   
    

    
}
