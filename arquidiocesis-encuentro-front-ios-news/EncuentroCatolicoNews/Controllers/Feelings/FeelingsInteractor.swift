//
//  FeelingsInteractor.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 14/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

public class FeelingsInteractor: FeelingsInteractorProtocol {

    weak var presenter: FeelingsPresenterProtocol?
    
    //MARK: - Properties
    private var snService = SocialNetworkService()
    
    //MARK: - Feelings
    func getFeelings() {
        let request = snService.getRequestWOP(method: .feelingsAll)
        snService.makeRequest(request: request) { (data, error) in
            if let error = error {
                self.presenter?.didFinishGettingFeelingsWithErrors(error: error)
            } else {
                do {
                    guard let allData = data else { return }
                    let result = try JSONDecoder().decode(Feelings.self, from: allData)
                    self.presenter?.didFinishGettingFeelings(feelings: result)
                } catch  {
                    self.presenter?.didFinishGettingFeelingsWithErrors(error: SocialNetworkErrors.ResponseError)
                }
            }
        }
    }
}
