//
//  ForgotPProtocols.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

// MARK: ROUTER -
protocol ForgotRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol ForgotPresenterProtocol: class {
    func postData(dataEmail: String)
    func getStatus(status: HTTPURLResponse)
    
}

// MARK: INTERACTOR -
protocol ForgotInteractorProtocol: class {
    var presenter: ForgotPresenterProtocol? { get set }
    func postEmail(email: String)
    
}

// MARK:  VIEW -
protocol ForgotViewProtocol: class {
    var presenter: ForgotPresenterProtocol? { get set }
    func statusResponse()
    func failRequest()
}

