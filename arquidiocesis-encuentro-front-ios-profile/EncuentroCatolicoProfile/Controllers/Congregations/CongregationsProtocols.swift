//
//  CongregationsProtocols.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation
import UIKit

//MARK: ROUTER -
protocol CongregationsRouterProtocol: AnyObject {
    
}

// MARK: PRESENTER -
protocol CongregationsPresenterProtocol: AnyObject {
    func requestListCongregations()
    func transportSuccesDataResponse(data: CongregationsList)
    func transportFailDataResponse()         
}

// MARK: INTERACTOR -
protocol CongregationsInteractorProtocol: AnyObject {
    var presenter: CongregationsPresenterProtocol? { get set }
    func getCongregations()
}

// MARK: VIEW -
protocol CongregationsViewProtocol: AnyObject {
    var presenter: CongregationsPresenterProtocol? { get set }
    func succesResponse(data: CongregationsList)
    func failResponse()         
}

