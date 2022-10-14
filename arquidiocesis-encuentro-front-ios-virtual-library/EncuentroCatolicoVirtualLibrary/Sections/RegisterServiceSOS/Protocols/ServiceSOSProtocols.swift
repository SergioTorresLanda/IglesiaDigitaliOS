//
//  ServiceSOSProtocols.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import UIKit

protocol ServiceSOSViewType: class {
    var presenter: ServiceSOSPresenterType? { get set }
    func setPriestLabel(priest: Priest)
    func didRegisterService(_ status: Bool)
    func showLoading()
    func hideLoading()
}

protocol ServiceSOSWireframeType: class {
    static func createServiceSOSModule(priest: Priest, serviceSOS: ServiceSOS) -> UIViewController
}

protocol ServiceSOSPresenterType: class {
    var priest: Priest! { get set }
    var serviceSOS: ServiceSOS! { get set }
    var view: ServiceSOSViewType? { get set }
    var interactor: ServiceSOSInteractorInputsType? { get set }
    var wireframe: ServiceSOSWireframeType? { get set }

    func onViewDidLoad()
    func onRegisterService(withParameters parameters: [String: Any?])
}

protocol ServiceSOSInteractorInputsType: class {
    var presenter: ServiceSOSInteractorOutputsType? { get set }
    func registerServices(parameters: [String: Any?])
}

protocol ServiceSOSInteractorOutputsType: class {
    func didRegisterServicesSuccess(_ status: Bool)
}

protocol ServiceSOSRemoteDataManagerType: class {
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void)
}
