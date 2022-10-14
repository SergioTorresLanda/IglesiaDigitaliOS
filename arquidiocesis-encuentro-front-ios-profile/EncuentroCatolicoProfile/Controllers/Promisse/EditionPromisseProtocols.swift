//
//  EditionPromisseProtocols.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

protocol EditionPromisseInteractorProtocol : class{
    func getCatalogSaints()
    func getCatalogTimePromise()
    func getCatalogImageSaints()
}



protocol EditionPromissePresenterProtocol: class {
    func validatePromisseForm(promiseModel: PromiseModel)
    func getCatalogs()
}

protocol EditionPromisseInteractorToPresenterProtocol: class {
    func responseSaints(response:[SaintsModel])
    func responseTimePromise(response:[TimerPromiseModel])
    func responseImageSaints(response: [ImageSaintsModel])
}



protocol PromissePresenterToUIViewControllerProtocol:class {
    func refreshSaints(response:[SaintsModel])
    func refreshTimePromise(response:[TimerPromiseModel])
    func refreshImageSaints(response:[ImageSaintsModel])
    func displayCustomAlert(pharraphers:NSAttributedString,  image: String)
}

protocol PromisseUIViewControllerProtocol:class {
    func setupComponents()
    func setupComponentsConstraint()
    func crearPromisseWithPicker(components: [UITextField],pickers: [UIPickerView])
}



protocol EditionPromisseRouterProtocol:class {
    func pushToPromisseAlert()
}
