//
//  ServiceSOSWireframe.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import UIKit

open class ServiceSOSWireframe: ServiceSOSWireframeType {
    public static func createServiceSOSModule(priest: Priest, serviceSOS: ServiceSOS) -> UIViewController {
        let view: ServiceSOSViewType = ServiceSOSViewController()
        let presenter: ServiceSOSPresenterType & ServiceSOSInteractorOutputsType = ServiceSOSPresenter()
        let interactor: ServiceSOSInteractorInputsType = ServiceSOSInteractor()
        let wireframe: ServiceSOSWireframeType = ServiceSOSWireframe()

        view.presenter = presenter
        presenter.priest = priest
        presenter.serviceSOS = serviceSOS
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter

        if let view = view as? ServiceSOSViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
