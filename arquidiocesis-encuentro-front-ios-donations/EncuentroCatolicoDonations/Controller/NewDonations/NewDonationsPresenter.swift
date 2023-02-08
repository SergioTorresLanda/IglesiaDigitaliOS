//
//  NewDonationsPresenter.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.
//

import Foundation

class NewDonationsPresenter: NewDontaionsPresneterProtocol {
    weak private var view:  NewDontaionsViewProtocol?
    var interactor: NewDontaionsInteractorProtocol?
    private let router: NewDonationsRouterProtocol?
    
    init (interface: Home_MiOfrenda, router: NewDonationsRouterProtocol, interactor: NewDontaionsInteractorProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestChurchList(category: String) {
        interactor?.getChurchList(category: category)
    }
    
    func onSuccessChurchList(data: ChurchesDontaions, responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.successGetChurches(data: data)
            }else{
                self.view?.failGetChurches(message: "\(responseCode.statusCode) error")
            }
        }
        
    }
    
    func onFailChurchList(error: Error) {
        DispatchQueue.main.async {
            self.view?.failGetChurches(message: error.localizedDescription)
        }
       
    }
    
// MARK: SUGGESTED LIST SERVICES -
    func requestSuggestedList() {
        interactor?.getSuggestedChurchList()
    }
    
    func onSuccessSuggestedList(data: [ChurchesSuggested], responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.successGetSuggested(data: data)
            }else{
                self.view?.failGetSuggested(message: "Error \(responseCode.statusCode) -----")
            }
        }
    }
    
    func onFailSuggestedList(error: Error) {
        DispatchQueue.main.async {
            self.view?.failGetSuggested(message: error.localizedDescription)
        }
    }
    
// MARK: SAVE BILLING DATA SERVICES -
    func requestBillingData() {
        interactor?.getBillingData()
    }
    
    func onSuccessGetBillingData(data: [BillingData], reponseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            if reponseCode.statusCode == 200 {
                self.view?.successGetBillingData(data: data)
            }else{
                self.view?.failGetBillingData(message: "Error \(reponseCode)")
            }
        }
    }
    
    func onFailGetBillingData(error: Error) {
        DispatchQueue.main.async {
            self.view?.failGetBillingData(message: error.localizedDescription)
        }
    }
    
    func saveBillingData(method: String, taxId: Int, businessName: String, rfc: String, address: String, neighborhood: String, zipCode: String, municipality: String, email: String, automaticBilling: Bool) {
        interactor?.saveBillingData(method: method, taxId: taxId, businessName: businessName, rfc: rfc, address: address, neighborhood: neighborhood, zipCode: zipCode, municipality: municipality, email: email, automaticBilling: automaticBilling)
    }
    
    func onSuccessSaveData(responseCode: HTTPURLResponse, method: String) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 || responseCode.statusCode == 201 {
                self.view?.successSaveBillingData(method: method)
            }else{
                self.view?.failSaveBillingData(message: "Error \(responseCode.statusCode)")
            }
        }
    }
    
    func onFailSaveData(error: Error) {
        DispatchQueue.main.async {
            self.view?.failSaveBillingData(message: error.localizedDescription)
        }
    }
    
}
