//
//  OnBoardingCCPresenter.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import Foundation
import UIKit

class OnBoardingCCPresenter  {
    
    // MARK: Properties
    weak var view: OnBoardingCCProtocol?
    var interactor: OnBoardingCCInteractorInputProtocol?
    var wireFrame: OnBoardingCCWireFrameProtocol?
    
}

extension OnBoardingCCPresenter: OnBoardingCCPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        
    }
    
    func omitir(controller: UIViewController) {
        interactor?.guardar()
        wireFrame?.omitir(controller: controller)
    }
    
    func fin(controller: UIViewController) {
        wireFrame?.fin(controller: controller)
        
    }
}

extension OnBoardingCCPresenter: OnBoardingCCInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
