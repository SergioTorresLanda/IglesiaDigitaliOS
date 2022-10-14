//
//  IntentionsCommunitiesPresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 08/09/21.
//

import Foundation
import UIKit

class IntentionsCommunitiesPresenter: IntentionsCommunitiesPresenterProtocol {
    
    weak private var view: IntentionsCommunitiesViewProtocol?
    var interactor: IntentionsCommunitiesInteractorProtocol?
    private let router: IntentionsCommunitiesRouterProtocol?
    
    init(interface: IntentionsCommunitiesViewProtocol, interactor: IntentionsCommunitiesInteractorProtocol, router: IntentionsCommunitiesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

