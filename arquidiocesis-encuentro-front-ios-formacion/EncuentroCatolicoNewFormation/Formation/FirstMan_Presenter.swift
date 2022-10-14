//
//  FirstMan_Presenter.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 07/05/21.
//

import UIKit

/// [View] --> [Presenter] --> [Interactor]
protocol SSVIPER_ViewToPresenterProtocol: class {
    var _view: SSVIPER_PresenterToViewProtocol? { get set }
    var _interactor: SSVIPER_PresenterToInteractorProtocol? { get set }
    var _router: SSVIPER_PresenterToRouter? { get set }
    var navigation: UINavigationController? {get set}
    func getData()
    func goNext(url: String)
    func cancelRequest()
    func closeSesion()
    func getDataCatalog()
}
/// [View] <-- [Presenter] <-- [Interactor]
protocol SSVIPER_InteractorToPresenterProtocol: class {
    func setData(data: FF_FormationObj_Entity)
    func setDataSingle(data: [FF_Formation_Entity])
    func successcloseSesion(data : String?, msg : String?)
    func errorCloseSesion(code : Int?, msg : String? )
    func setDataCatalog(dataCatalog: FF_CatalogObj_Entity)
}

class SVS_ProfilePresenter: SSVIPER_ViewToPresenterProtocol {
    
    func getDataCatalog() {
        self._interactor?.getDataCatalog()
    }
    
    var _router: SSVIPER_PresenterToRouter?
    var _view: SSVIPER_PresenterToViewProtocol?
    var _interactor: SSVIPER_PresenterToInteractorProtocol?
    var navigation: UINavigationController?
    
    func getData(){
        self._interactor?.getData()
    }
    
    
    func goNext(url: String) {
        guard let navigation = navigation else { debugPrint("Can't create navigation"); return }
        self._router?.goToNextView(navigation: navigation, url: url)
    }
    
    func cancelRequest() {
        print("cancelRequest")
    }
    
    func closeSesion() {
        print("closeSesion")
    }
}


extension SVS_ProfilePresenter: SSVIPER_InteractorToPresenterProtocol{
    
    func setDataCatalog(dataCatalog: FF_CatalogObj_Entity) {
        self._view?.setDataCatalog(data: dataCatalog)
    }
    
    func setData(data: FF_FormationObj_Entity){
        self._view?.setData(data: data)
    }
    
    
    func setDataSingle(data: [FF_Formation_Entity]){
        self._view?.setDataChild(data: data)
    }
    
    func successcloseSesion(data: String?, msg: String?) {
        print("successcloseSesion")
    }
    
    func errorCloseSesion(code: Int?, msg: String?) {
        print("errorCloseSesion")
    }
    
    
}
