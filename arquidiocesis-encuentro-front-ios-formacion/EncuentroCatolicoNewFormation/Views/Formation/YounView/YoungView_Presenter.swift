//
//  YoungView_Presenter.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit

/// [View] --> [Presenter] --> [Interactor]
protocol FYV_VIPER_ViewToPresenterProtocol: AnyObject {
    var _view: FYV_VIPER_PresenterToViewProtocol? { get set }
    var _router: SSVIPER_PresenterToRouter? { get set }
    var _interactor: FYV_VIPER_PresenterToInteractorProtocol? { get set }
    var navigation: UINavigationController? {get set}
    
    func getData(strTypeCatalog: String)
    func getCatalogData()
    func goNext(url: String)
    func showSpinner()
    func hideSpinner()
}

protocol FYV_VIPER_InteractorToPresenterProtocol: AnyObject {
    func setDataSingle(data: [FF_Formation_Entity])
    func setDataCatalog(data: FF_CatalogObj_Entity)
    func onError(msg: String)
}

class FYV_ProfilePresenter: FYV_VIPER_ViewToPresenterProtocol {

    
    var _router: SSVIPER_PresenterToRouter?
    var _view: FYV_VIPER_PresenterToViewProtocol?
    var _interactor: FYV_VIPER_PresenterToInteractorProtocol?
    var navigation: UINavigationController?
    
    func getData(strTypeCatalog: String){
        self._interactor?.getData(strTypeCatalog: strTypeCatalog)
    }
    
    func goNext(url: String) {
        DispatchQueue.main.async { [weak self] in
            guard let navigation = self?.navigation else { return }
            
            self?._router?.goToNextView(navigation: navigation, url: url)
        }
    }
    
    func getCatalogData() {
        _interactor?.getFormationCatalog()
    }
    
    func showSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let navigation = self?.navigation else { return }
            
            self?._router?.showSpinner(navigation: navigation)
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let navigation = self?.navigation else { return }
            
            self?._router?.hideSpinner(navigation: navigation)
        }
    }
}

extension FYV_ProfilePresenter: FYV_VIPER_InteractorToPresenterProtocol {
    func onError(msg: String) {
        DispatchQueue.main.async { [weak self] in
            guard let navigation = self?.navigation else { return }
            
            self?._router?.hideSpinner(navigation: navigation)
            self?._router?.goToErrorView(navigation: navigation, title: "Alerta", message: msg)
        }
    }
    
    func setDataCatalog(data: FF_CatalogObj_Entity) {
        DispatchQueue.main.async { [weak self] in
            self?._view?.setDataCatalog(data: data.data)
        }
    }
    
    func setDataSingle(data: [FF_Formation_Entity]){
        DispatchQueue.main.async { [weak self] in
            self?._view?.setDataChild(data: data)
        }
    }
}

