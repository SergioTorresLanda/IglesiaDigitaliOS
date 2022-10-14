//
//  NewOnboardingProtocols.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 13/09/21.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol NewOnboardingRouterProtocol: AnyObject {
    
}

// MARK:  PRESENTER -
protocol NewOnboardingPresenterProtocol: AnyObject {
    
}

// MARK: INTERACTOR -
protocol NewOnboardingInteractorProtocol: AnyObject {
    var presenter: NewOnboardingPresenterProtocol? { get set }
}

// MARK: VIEW -
protocol NewOnboardingViewProtocol: AnyObject {
    var presenter: NewOnboardingPresenterProtocol? { get set }
}

