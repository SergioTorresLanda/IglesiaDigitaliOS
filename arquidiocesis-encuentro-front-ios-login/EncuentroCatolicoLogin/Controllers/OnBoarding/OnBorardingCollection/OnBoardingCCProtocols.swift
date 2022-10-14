//
//  OnBoardingCCProtocols.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import Foundation
import UIKit

protocol OnBoardingCCProtocol: class {
    // PRESENTER -> VIEW
    var presenter: OnBoardingCCPresenterProtocol? { get set }
}

protocol OnBoardingCCWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    
    func omitir(controller: UIViewController)
    func fin(controller: UIViewController)
}

protocol OnBoardingCCPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: OnBoardingCCProtocol? { get set }
    var interactor: OnBoardingCCInteractorInputProtocol? { get set }
    var wireFrame: OnBoardingCCWireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func omitir(controller: UIViewController)
    func fin(controller: UIViewController)
}

protocol OnBoardingCCInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol OnBoardingCCInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: OnBoardingCCInteractorOutputProtocol? { get set }
    var localDatamanager: OnBoardingCCLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: OnBoardingCCRemoteDataManagerInputProtocol? { get set }
    
    func guardar()
}

protocol OnBoardingCCDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol OnBoardingCCRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: OnBoardingCCRemoteDataManagerOutputProtocol? { get set }
}

protocol OnBoardingCCRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol OnBoardingCCLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
