//
//  FirstMan_Protocols.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Alejandro on 20/10/22.
//

import UIKit

/// [View] <-- [Presenter] <-- [Interactor]
protocol SSVIPER_InteractorToPresenterProtocol: AnyObject {
    func setData(data: FF_FormationObj_Entity)
    func setDataSingle(data: [FF_Formation_Entity])
    func successcloseSesion(data : String?, msg : String?)
    func errorCloseSesion(code : Int?, msg : String? )
    func setDataCatalog(dataCatalog: FF_CatalogObj_Entity)
}

protocol SSVIPER_PresenterToInteractorProtocol: AnyObject {
    var _presenter: SSVIPER_InteractorToPresenterProtocol? {set get}
    func closeSesion()
    func cancelAnyRequest()
    func getData()
    func getDataCatalog()
}

protocol SSVIPER_PresenterToRouter {
    @MainActor
    func goToNextView(navigation: UINavigationController, url: String)
    @MainActor
    func showSpinner(navigation: UINavigationController)
    @MainActor
    func hideSpinner(navigation: UINavigationController)
    @MainActor
    func goToErrorView(navigation: UINavigationController, title: String, message: String)
}

protocol FYV_VIPER_PresenterToViewProtocol: AnyObject {
    var _presenter : FYV_VIPER_ViewToPresenterProtocol? {set get}
    
    @MainActor
    func setDataChild(data: [FF_Formation_Entity])
    @MainActor
    func setDataCatalog(data: [FF_Catalog_Entity])
}

    
