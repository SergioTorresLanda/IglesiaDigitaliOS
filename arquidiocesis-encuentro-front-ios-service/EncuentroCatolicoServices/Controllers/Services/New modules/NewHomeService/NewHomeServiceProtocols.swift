//
//  NewHomeServiceProtocols.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

// MARK: ROUTER -
protocol NewHomeServiceRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol NewHomeServicePresenterProtocol: class {
    
}

// MARK: INTERACTOR -
protocol NewHomeServiceInteractorProtocol: class {
    var presenter: NewHomeServicePresenterProtocol? { get set }
}

// MARK: VIEW -
protocol NewHomeServiceViewProtocol: class {
    var presenter: NewHomeServicePresenterProtocol? { get set }
}

