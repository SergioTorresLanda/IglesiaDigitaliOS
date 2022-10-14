//
//  ConfirmationCodeProtocol.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

// MARK: ROUTER -
protocol ConfirmationCodeRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol ConfirmationCodePresenterProtocol: class {
    func postParamsChange(email: String, code: String, input: String)
    func getStatusPost()
    func postData2(dataEmail: String)
    func getStatus2()
    func getErrorPost()
    func requestUserInfo(email: String)
    func successUserInfo(data: UserInfo)
    func failUserInfo()
    
}

// MARK: INTERACTOR -
protocol ConfirmationCodeInteractorProtocol: class {
    var presenter: ConfirmationCodePresenterProtocol? { get set }
    func postParams(email: String, code: String, inputP: String)
    func postEmail2(email: String)
    func getUserInfo(email: String)
}

// MARK:  VIEW -
protocol ConfirmationCodeViewProtocol: class {
    var presenter: ConfirmationCodePresenterProtocol? { get set }
    func succesChange()
    func statusResponse2()
    func errorChange()
    func succesUserInfo(data: UserInfo)
    func failUserInfo()
        
    
}


