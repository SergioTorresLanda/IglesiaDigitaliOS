//
//  NewDonationsProtocols.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol NewDonationsRouterProtocol: AnyObject {
    
}

// MARK: PRESENTER -
protocol NewDontaionsPresneterProtocol: AnyObject {
    func requestChurchList(category: String)
    func onSuccessChurchList(data: ChurchesDontaions, responseCode: HTTPURLResponse)
    func onFailChurchList(error: Error)
    
    func requestSuggestedList()
    func onSuccessSuggestedList(data: [ChurchesSuggested], responseCode: HTTPURLResponse)
    func onFailSuggestedList(error: Error)
    
    func saveBillingData(method: String, taxId: Int, businessName: String, rfc: String, address: String, neighborhood: String, zipCode: String, municipality: String, email: String, automaticBilling: Bool)
    func onFailSaveData(error: Error)
    func onSuccessSaveData(responseCode: HTTPURLResponse, method: String)
    
    func requestBillingData()
    func onSuccessGetBillingData(data: [BillingData], reponseCode: HTTPURLResponse)
    func onFailGetBillingData(error: Error)
    
}

// MARK: INTERACTOR -
protocol NewDontaionsInteractorProtocol: AnyObject {
    var presenter: NewDontaionsPresneterProtocol? { get set }
    func getChurchList(category: String)
    func getSuggestedChurchList()
    
    func saveBillingData(method: String, taxId: Int, businessName: String, rfc: String, address: String, neighborhood: String, zipCode: String, municipality: String, email: String, automaticBilling: Bool)
    
    func getBillingData()
    
}

// MARK: VIEW -
protocol NewDontaionsViewProtocol: AnyObject {
    var presenter: NewDontaionsPresneterProtocol? { get set }
    func successGetChurches(data: ChurchesDontaions)
    func failGetChurches(message: String)
    
    func successGetSuggested(data: [ChurchesSuggested]) 
    func failGetSuggested(message: String)
    
    func successSaveBillingData(method: String) 
    func failSaveBillingData(message: String)
    
    func successGetBillingData(data: [BillingData])     
    func failGetBillingData(message: String)
    
}
