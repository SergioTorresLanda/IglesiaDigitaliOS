//
//  ServiceSOSPresenter.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import Foundation

final class ServiceSOSPresenter: ServiceSOSPresenterType, ServiceSOSInteractorOutputsType {
    var priest: Priest!
    var serviceSOS: ServiceSOS!

    weak var view: ServiceSOSViewType?
    var interactor: ServiceSOSInteractorInputsType?
    var wireframe: ServiceSOSWireframeType?

    func onViewDidLoad() {
        view?.setPriestLabel(priest: priest)
    }

    func onRegisterService(withParameters parameters: [String: Any?]) {
        view?.showLoading()
        interactor?.registerServices(parameters: parameters)
    }

    func didRegisterServicesSuccess(_ status: Bool) {
        view?.hideLoading()
        view?.didRegisterService(status)
    }
}
