//
//  EditionPromissePresenter.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

class EditionPromissePresenter: NSObject {
    weak var view : EditionPromisseViewController?
    var interactor: EditionPromisseInteractor?
    var dataManager = EditionPromisseDataManager.shareInstance
}

extension EditionPromissePresenter: EditionPromissePresenterProtocol{
    func getCatalogs() {
        interactor?.getCatalogSaints()
        interactor?.getCatalogTimePromise()
        interactor?.getCatalogImageSaints()
    }
    
    func validatePromisseForm(promiseModel: PromiseModel) {
        guard (promiseModel.periodInterval != ""),
              (promiseModel.promisseTo != ""),
              (promiseModel.promisseDescription != ""),
              (promiseModel.profileID != "") else {
            return
        }
        
        let attributesMedium: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .regular
            ),
            .foregroundColor: #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        ]
        let attributesBold: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        ]
        let attributedFirst = NSMutableAttributedString(string: "Prometiste a ", attributes: attributesMedium)
        let attributedSecond = NSAttributedString(string: " por ", attributes: attributesMedium)
        
        let attributedPromisseTo = NSAttributedString(string: promiseModel.promisseTo, attributes: attributesBold)
        let attributedPromisseDescription = NSAttributedString(string: " \(promiseModel.promisseDescription ?? "")", attributes: attributesBold)
        let attributedPeriodInterval = NSAttributedString(string: promiseModel.periodInterval ?? "", attributes: attributesBold)
        
        attributedFirst.append(attributedPromisseTo)
        attributedFirst.append(attributedPromisseDescription)
        attributedFirst.append(attributedSecond)
        attributedFirst.append(attributedPeriodInterval)
        view?.displayCustomAlert(pharraphers: attributedFirst, image: promiseModel.imageSaint ?? "")
        dataManager.addNewPromise(promisse: promiseModel)
    }
}

extension EditionPromissePresenter: EditionPromisseInteractorToPresenterProtocol{
    func responseImageSaints(response: [ImageSaintsModel]) {
        view?.refreshImageSaints(response: response)
    }
    
    func responseTimePromise(response: [TimerPromiseModel]) {
        view?.refreshTimePromise(response: response)
    }
    
    func responseSaints(response: [SaintsModel]) {
        view?.refreshSaints(response: response)
    }
    
}
