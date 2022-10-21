//
//  AdultView_Presenter.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit

/// [View] --> [Presenter] --> [Interactor]
protocol FAV_VIPER_ViewToPresenterProtocol: class {
    var _view: FAV_VIPER_PresenterToViewProtocol? { get set }
    var _interactor: FAV_VIPER_PresenterToInteractorProtocol? { get set }
    var _router: SSVIPER_PresenterToRouter? { get set }
    var navigation: UINavigationController? {get set}
    func getData()
    func goNext(url: String)
}
/// [View] <-- [Presenter] <-- [Interactor]
protocol FAV_VIPER_InteractorToPresenterProtocol: class {
    func setDataSingle(data: [FF_Formation_Entity])
}

class FAV_ProfilePresenter: FAV_VIPER_ViewToPresenterProtocol {
    
    var _router: SSVIPER_PresenterToRouter?
    var _view: FAV_VIPER_PresenterToViewProtocol?
    var _interactor: FAV_VIPER_PresenterToInteractorProtocol?
    var navigation: UINavigationController?
    
    func getData(){
        self._interactor?.getData()
    }
    
    func goNext(url: String) {
        guard let navigation = navigation else { debugPrint("Can't create navigation"); return }
        self._router?.goToNextView(navigation: navigation, url: url)
    }
}


extension FAV_ProfilePresenter: FAV_VIPER_InteractorToPresenterProtocol{
    
    func setDataSingle(data: [FF_Formation_Entity]){
        self._view?.setDataChild(data: data)
    }
    
}
