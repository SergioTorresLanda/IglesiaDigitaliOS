//
//  IntentionsCommunitiesProtocol.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 08/09/21.
//

import UIKit

// MARK: ROUTER -
protocol IntentionsCommunitiesRouterProtocol: AnyObject {
    
}

// MARK: - PRESENTER
protocol IntentionsCommunitiesPresenterProtocol: AnyObject {
    
}

// MARK: INTERACTOR -
protocol IntentionsCommunitiesInteractorProtocol: AnyObject {
    var presenter: IntentionsCommunitiesPresenterProtocol? { get set }
}

// MARK: VIEW -
protocol IntentionsCommunitiesViewProtocol: AnyObject {
    var presenter: IntentionsCommunitiesPresenterProtocol? { get set }
}


