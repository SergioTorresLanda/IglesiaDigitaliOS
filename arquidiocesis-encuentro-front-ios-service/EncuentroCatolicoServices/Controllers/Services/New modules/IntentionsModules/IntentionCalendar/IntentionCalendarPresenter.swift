//
//  IntentionCalendarPresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 29/07/21.
//

import Foundation
import UIKit

class IntentionCalendarPresenter: IntentionCalendarPresenterProtocol {
    
    weak private var view: IntentionCalendarViewProtocol?
    var interactor: IntentionCalendarInteractorProtocol?
    private let router: IntentionCalendarRouterProtocol?
    
    init(interface: IntentionCalendarViewProtocol, interactor: IntentionCalendarInteractorProtocol, router: IntentionCalendarRouterProtocol) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    
}
