//
//  ChurchDetailProtocols.swift
//  Encuentro
//
//  Created by Edgar Hernandez Solis on 02/12/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

protocol ChurchDetailViewProtocol: class {
    var presenter: ChurchDetailPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showError(_ error: String)
    func showDetail(church: ChurchDetail)
    func isCorrectFavorite()
    func updateFavImage()
    func updateDeleteImage()
    func saveChurchSucces()
    func saveChurchError()
    func serviceCatalogSuccess(response: ServiceCatalogModel)
    func serviceCatalogError()
    func successRequestComments(data: Comments)     
    func failRequestComments()
    
}

protocol ChurchDetailWireFrameProtocol: AnyObject {
    static func presentChurchDetailModule(with id: Int, fromView vc: AnyObject, selector isPrincipal: Int)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushEdition(id: Int, from controller: AnyObject, churchDetail: ChurchDetail)
    func presentMyChurchesModule(fromView vc:AnyObject)
}

protocol ChurchDetailPresenterProtocol: AnyObject {
    var view: ChurchDetailViewProtocol? { get set }
    var interactor: ChurchDetailInteractorInputProtocol? { get set }
    var wireFrame: ChurchDetailWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getDetail(id: Int)
    func goToEdition(id: Int, churchDetail: ChurchDetail)
    func saveFavorite(id: Int, idPriest: Int, isPrincipal: Int)
    func removeFavorite(id: Int, idPriest: Int, isPrincipal: Int)
    
    func saveChurch(idLocation: Int, idPriest: Int)
    func removeChurch(idLocation: Int, idPriest: Int)
    func goToMyChourch()
    func putChurchEdition(locationId: Int, description: String, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, bankAcount: String, principal: Int, schedules: [AttentionEditChurch], attention: [AttentionEditChurch], masses: [MassEditChurch], services: [ServiceEditChurch])
    func getServiceCatalog()
    func requestListComments(queryParams: String)
   
    
}

protocol ChurchDetailInteractorOutputProtocol: AnyObject {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseDetail(result: ChurchDetail)
    func errorDetail(msg: String)
    func responseFavorite(errores: ServerErrors, data: [ModelResponseAddFav])
    func responseRemoveFavorite(errores: ServerErrors, data: [ModelResponseRemoveFavorites])
    
    func responseAddChurchSacerdote(msg: String?)
    func responseRemoveChurchSacerdote(msg: String?)
    func responsePutEditChurch(errores: ServerErrors, data: String?)
    func responseGetServiceCatalog(data: ServiceCatalogModel)
    func errorGetServiceCatalog(msg: String)
    func transportResponseCommentsList(contentData: Comments)
    func errorTransportCommentList(responseCode: HTTPURLResponse)
}

protocol ChurchDetailInteractorInputProtocol: AnyObject
{
    var presenter: ChurchDetailInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func getCommentsList(queryParam: String)
    func requestDetail(id: Int)
    func requestAddFavorite(id: Int, idPriest: Int, isPrincipal: Int)
    func requestRemoveFavorite(id: Int, idPriest: Int, isPrincipal: Int)
    func requestServiceCatalog()
    
    func requestAddFavoriteSacerdote(idLocation: Int, idPriest: Int)
    func requestRemoveChurchSacerdote(idLocation: Int, idPriest: Int)
    func saveChurchEdition(locationId: Int, description: String, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, bankAcount: String, principal: Int, schedules: [AttentionEditChurch], attention: [AttentionEditChurch], masses: [MassEditChurch], services: [ServiceEditChurch])
}
