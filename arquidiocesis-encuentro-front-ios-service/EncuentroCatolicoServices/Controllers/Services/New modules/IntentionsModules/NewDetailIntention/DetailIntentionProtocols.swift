//
//  DetailIntentionProtocols.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//
//
import Foundation
import UIKit

// MARK: ROUTER -
protocol DetailIntentionRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol DetailIntentionPresenterProtocol: class {
    func callRequestIntentionDetail(dateStr: String, hourStr: String)
    func passRequestResponseDetail(contentResponse: IntentionDetails, responseCode: HTTPURLResponse)
    func fatalErrorResponse()
    func callGetPDFRequest(dateStr: String, hourStr: String) 
    func succesGetPDFRequest(data: PDFObject) 
    func failGetPDFRequest()
        
}

// MARK: INTERACTOR -
protocol DetailIntentionInteractorProtocol: class {
    var presenter: DetailIntentionPresenterProtocol? { get set }
    func getDetailIntetion(dateStr: String, hour: String)
    func getDetailIntetionPDF(dateStr: String, hour: String)
}

// MARK: VIEW -
protocol DetailIntentionViewProtocol: class {
    var presenter: DetailIntentionPresenterProtocol? { get set }
    func successRequestIntention(contentResponse: IntentionDetails)
    func failRequestIntention()
    func fatalError()
    func succesPDFRequest(data: PDFObject)
    func failPDFRequest()
        
}

