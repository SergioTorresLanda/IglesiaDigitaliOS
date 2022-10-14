//
//  RouterBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation
import UIKit
open class BibliotecaRecursosRouter:  BibliotecaRecursosRouterProtocol {
    
    public static func presentModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "BibliotecaRecursos", bundle: Bundle(for: BlibliotecaRecursosView.self))
        let view:BibliotecaRecursosViewProtocol = storyboard.instantiateViewController(withIdentifier: "BlibliotecaRecursosView") as! BlibliotecaRecursosView
        let presenter: BibliotecaRecursosPresenterProtocol & BibliotecaRecursosOutputInteractorProtocol = BibliotecaRecursosPresenter()
        let interactor: BibliotecaRecursosInputInteractorProtocol = BibliotecaRecursosInteractor()
        let router: BibliotecaRecursosRouterProtocol = BibliotecaRecursosRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    
}
