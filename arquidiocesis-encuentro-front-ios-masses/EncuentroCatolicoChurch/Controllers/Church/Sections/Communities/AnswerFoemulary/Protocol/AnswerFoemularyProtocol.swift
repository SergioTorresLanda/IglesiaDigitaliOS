//
//  AnswerFoemularyProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import Foundation

protocol AnswerFoemularyViewProtocol: AnyObject {
    var presenter: AnswerFoemularyPresenterProtocol? { get set }
    func communityTypeSuccess(response: CommunityTypeCatalog)
    func postAddCommunitySuccess()
    func postAddCommunityFail(message: String)
}

protocol AnswerFoemularyWireFrameProtocol: AnyObject {
    static func presentAnswerFoemularyModule(fromView vc: AnyObject)
}

protocol AnswerFoemularyPresenterProtocol: AnyObject {
    var view: AnswerFoemularyViewProtocol? { get set }
    var interactor: AnswerFoemularyInteractorInputProtocol? { get set }
    var wireFrame: AnswerFoemularyWireFrameProtocol? { get set }
    func callComunityType()
    func sendCommunityType(name: String, address: String, long: Double, lat: Double, email: String, phone: String, type: Int)
    
}

protocol AnswerFoemularyInteractorOutputProtocol: AnyObject {
    func communityTypeResponse(response: CommunityTypeCatalog)
    func communityTupeError(msg: String)
    func responseAddCommunity(errores: ServerErrors, data: CommunityTypeModel?)
}

protocol AnswerFoemularyInteractorInputProtocol: AnyObject {
    var presenter: AnswerFoemularyInteractorOutputProtocol? { get set }
    func getCommunityType()
    func postCommunity(name: String, address: String, long: Double, lat: Double, email: String, phone: String, type: Int)
}
