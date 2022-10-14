//
//  NewOnboardingPresenter.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 13/09/21.
//

import Foundation
import UIKit

class NewOnboardingPresenter: NewOnboardingPresenterProtocol {
    weak private var view: NewOnboardingViewProtocol?
    var interactor: NewOnboardingInteractorProtocol?
    private let router: NewOnboardingRouterProtocol?
    
    init(interface: NewOnboardingViewProtocol, interactor: NewOnboardingInteractorProtocol, router: NewOnboardingRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func goToNexView(view: UIViewController) {
        
    }
    
}
