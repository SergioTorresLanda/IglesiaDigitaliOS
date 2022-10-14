//
//  NewListIntentionsProtocols.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol NewListIntentionsRouterProtocol: class {
}

// MARK: PRESENTER -
protocol NewListIntentionsPresenterProtocol: class {
    func callRequestList(locationID: String, dateStr: String)
    func handleResponseRequest(contentResponse: [ListIntentions], responseCode: HTTPURLResponse)
    
}

// MARK: INTERACTOR -
protocol NewListIntentionsInteractorProtocol: class {
    var presenter: NewListIntentionsPresenterProtocol? { get set }
    func getListIntetions(locationID: String, dateStr: String)
    
}

// MARK: VIEW -
protocol NewListIntentionsViewProtocol: class {
    var presenter: NewListIntentionsPresenterProtocol? { get set }
    func succesRequestList(contentResponse: [ListIntentions])
    func failrequestList()
    
}

