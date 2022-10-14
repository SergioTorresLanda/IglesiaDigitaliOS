//
//  IntentionCalendarProtocol.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 29/07/21.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol IntentionCalendarRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol IntentionCalendarPresenterProtocol: class {
    
}

// MARK: INTERACTOR -
protocol IntentionCalendarInteractorProtocol: class {
    var presenter: IntentionCalendarPresenterProtocol? { get set }
}

// MARK: VIEW -
protocol IntentionCalendarViewProtocol: class {
    var presenter: IntentionCalendarPresenterProtocol? { get set }
    
}


