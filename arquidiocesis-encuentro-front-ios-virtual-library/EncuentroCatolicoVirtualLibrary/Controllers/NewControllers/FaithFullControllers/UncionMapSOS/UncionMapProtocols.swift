//
//  UncionMapProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 20/07/21.
//

import UIKit

// MARK: ROUTER -
protocol UncionMapRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol UncionMapPresenterProtocol: class {
    
}

// MARK: INTERACTOR -
protocol UncionMapInteractorProtocol: class {
    var presenter: UncionMapPresenterProtocol? { get set }
}

// MARK: VIEW -
protocol UncionMapViewProtocol: class {
    var presenter: UncionMapPresenterProtocol? { get set }
}


