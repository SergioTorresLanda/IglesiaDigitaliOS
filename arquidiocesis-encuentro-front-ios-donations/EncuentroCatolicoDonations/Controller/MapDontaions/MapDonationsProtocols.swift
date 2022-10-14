//
//  MapDonationsProtocols.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 15/03/22.
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
