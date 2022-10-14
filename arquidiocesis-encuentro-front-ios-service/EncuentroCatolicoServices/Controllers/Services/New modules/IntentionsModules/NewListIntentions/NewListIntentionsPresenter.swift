//
//  NewListIntentionsPresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class NewListIntentionsPresneter: NewListIntentionsPresenterProtocol {
    weak private var view: NewListIntentionsViewProtocol?
    var interactor: NewListIntentionsInteractorProtocol?
    private let router: NewListIntentionsRouterProtocol?
    
    init(interface: NewListIntentionsViewProtocol, interactor: NewListIntentionsInteractorProtocol, router: NewListIntentionsRouterProtocol) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func callRequestList(locationID: String, dateStr: String) {
        interactor?.getListIntetions(locationID: locationID, dateStr: dateStr)
    }
    
    func handleResponseRequest(contentResponse: [ListIntentions], responseCode: HTTPURLResponse) {
        
        DispatchQueue.main.async {
            
            if responseCode.statusCode == 200 {
                self.view?.succesRequestList(contentResponse: contentResponse)
            }else{
                self.view?.failrequestList()
            }
        }
    }
    
    
    
}
