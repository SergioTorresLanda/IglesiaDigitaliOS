//
//  SPresenter.swift
//  baz-buy
//
//  Created by Monserrat Caballero on 28/10/20.
//

import UIKit
/// [View] --> [Presenter] --> [Interactor]
protocol SQRViewToPresenterProtocol: class {
    var _view: SQRPresenterToViewProtocol? { get set}
    var _interactor: SQRPresenterToInteractorProtocol? { get set }
    var _router: SQRPresenterToRouter? { get set }
    var navigation: UINavigationController? { get set }
    func goNext(_ code: String, _ amm0unt: String)
    func getData()
    func getDataRequest(data: SendQR)
    func cancelNext(toRoot: Bool)
    func cancelRequest()
}
/// [View] <-- [Presenter] <-- [Interactor]
protocol SQRInteractorToPresenterProtocol: class {
    func setData()
    
    func returnRequest(data: [String])
    func returnRequestFailure(code: Int, msg: String)
}

class SQRPresenter: SQRViewToPresenterProtocol {
    var _view: SQRPresenterToViewProtocol?
    var _interactor: SQRPresenterToInteractorProtocol?
    var _router: SQRPresenterToRouter?
    var navigation: UINavigationController?
    
    func goNext(_ code: String, _ amm0unt: String) {
        if let navigation = navigation {
            _router?.setNextFlow(navigationController: navigation, code, amm0unt)
        } else {
            debugPrint("No navigacion set")
        }
    }
    
    func cancelNext(toRoot: Bool) {
        if let navigation = navigation {
            _router?.cancelNextFlow(navigationController: navigation, toRoot: toRoot)
        } else {
            debugPrint("No navigacion set")
        }
    }
    
    func getDataRequest(data: SendQR) {
        _interactor?.requestData(qrCode: data)
    }
    
    func getData() {
        setData()
    }
    
    func cancelRequest() {
        _interactor?.cancelAnyRequest()
    }
    
}

extension SQRPresenter: SQRInteractorToPresenterProtocol {
    
    func returnRequestFailure(code: Int, msg: String) {
        _view?.sendRequestFailure(code: code, msg: msg)
    }
    
    func returnRequest(data: [String]) {
        _view?.sendRequest(data: data)
    }
    
    func setData() {
        _view?.setData()
    }
    
}
