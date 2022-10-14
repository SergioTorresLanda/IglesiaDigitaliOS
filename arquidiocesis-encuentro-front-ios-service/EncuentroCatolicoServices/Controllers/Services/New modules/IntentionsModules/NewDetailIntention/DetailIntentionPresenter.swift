//
//  DetailIntentionPresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class DetailIntentionPresenter: DetailIntentionPresenterProtocol {
    
    weak private var view: DetailIntentionViewProtocol?
    var interactor: DetailIntentionInteractorProtocol?
    private let router: DetailIntentionRouterProtocol?
    
    init(interface: DetailIntentionViewProtocol, interactor: DetailIntentionInteractorProtocol, router: DetailIntentionRouterProtocol) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
    func callRequestIntentionDetail(dateStr: String, hourStr: String) {
        interactor?.getDetailIntetion(dateStr: dateStr, hour: hourStr)
    }
    
    func passRequestResponseDetail(contentResponse: IntentionDetails, responseCode: HTTPURLResponse) {
        
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.successRequestIntention(contentResponse: contentResponse)
            }else{
                self.view?.failRequestIntention()
            }
        }
        
    }
    
    func fatalErrorResponse() {
        DispatchQueue.main.async {
            self.view?.fatalError()
        }
    }
    
    func callGetPDFRequest(dateStr: String, hourStr: String) {
        interactor?.getDetailIntetionPDF(dateStr: dateStr, hour: hourStr)
    }
    
    func succesGetPDFRequest(data: PDFObject) {
        DispatchQueue.main.async {
            self.view?.succesPDFRequest(data: data)
        }
    }
    
    func failGetPDFRequest() {
        DispatchQueue.main.async {
            self.view?.failPDFRequest()
        }
    }
    
}
