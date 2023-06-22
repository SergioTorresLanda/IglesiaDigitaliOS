//
//  MapDonationsProtocols.swift
//  EncuentroCatolicoDonations
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol MapDonationsRouterProtocol: AnyObject {
}

// MARK: PRESENTER -
protocol MapDonationsPresneterProtocol: AnyObject {
}

// MARK: INTERACTOR -
protocol MapDonationsInteractorProtocol: AnyObject {
    var presenter: MapDonationsPresneterProtocol? { get set }
}

// MARK: VIEW -
protocol MapDonationsViewProtocol: AnyObject {
    var presenter: MapDonationsPresneterProtocol? { get set }
}
