//
//  YoungView_Presenter.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit

/// [View] --> [Presenter] --> [Interactor]
protocol FYV_VIPER_ViewToPresenterProtocol: class {
    var _view: FYV_VIPER_PresenterToViewProtocol? { get set }
    var _router: SSVIPER_PresenterToRouter? { get set }
    var _interactor: FYV_VIPER_PresenterToInteractorProtocol? { get set }
    var navigation: UINavigationController? {get set}
    func getData(strTypeCatalog: String)
    func goNext(url: String)
}
/// [View] <-- [Presenter] <-- [Interactor]
protocol FYV_VIPER_InteractorToPresenterProtocol: class {
    func setDataSingle(data: [FF_Formation_Entity])
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
        guard let navigation = navigation else { debugPrint("Can't create navigation"); return }
        self._router?.goToNextView(navigation: navigation, url: url)
    }
}


extension FYV_ProfilePresenter: FYV_VIPER_InteractorToPresenterProtocol{
    
    func setDataSingle(data: [FF_Formation_Entity]){
        self._view?.setDataChild(data: data)
    }
    
}

