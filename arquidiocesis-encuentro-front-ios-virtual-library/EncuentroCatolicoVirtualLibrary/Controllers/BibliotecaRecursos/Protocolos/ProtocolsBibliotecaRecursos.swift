//
//  ProtocolsBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation

import UIKit
protocol BibliotecaRecursosViewProtocol: class {
    var presenter: BibliotecaRecursosPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showError(_ error: String)
    func showResult(result: LibraryResourcesResponse)
    func showResultSearch(result: [LibrarySearchResponse])
    
}

protocol BibliotecaRecursosRouterProtocol: class {
    static func presentModule() -> UIViewController
   
}

protocol BibliotecaRecursosPresenterProtocol: class {
    var view: BibliotecaRecursosViewProtocol? { get set }
    var interactor: BibliotecaRecursosInputInteractorProtocol? { get set }
    var router: BibliotecaRecursosRouterProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getDataHome()
    func getDataSearch(text: String)
    func isError(msg: String)
    
}

protocol BibliotecaRecursosOutputInteractorProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseInteractorDataHome(result: LibraryResourcesResponse)
    func responseInteractorDataSearch(result: [LibrarySearchResponse])
    func isErrorServer(msg: String)
  
}

protocol BibliotecaRecursosInputInteractorProtocol: class
{
    var presenter: BibliotecaRecursosOutputInteractorProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestInteractorDataHome()
    func requestInteractorDataSeacrh(text: String)
    
}
