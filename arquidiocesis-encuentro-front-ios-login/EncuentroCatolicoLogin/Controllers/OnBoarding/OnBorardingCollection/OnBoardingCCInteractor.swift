//
//  OnBoardingCCInteractor.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import Foundation

class OnBoardingCCInteractor: OnBoardingCCInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: OnBoardingCCInteractorOutputProtocol?
    var localDatamanager: OnBoardingCCLocalDataManagerInputProtocol?
    var remoteDatamanager: OnBoardingCCRemoteDataManagerInputProtocol?
    
    func guardar() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "onboarding")
    }

}

extension OnBoardingCCInteractor: OnBoardingCCRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
