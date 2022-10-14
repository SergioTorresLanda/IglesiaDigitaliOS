//
//  FaithfulWireframe.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import UIKit

open class FaithfulWireframe: FaithfulWireframeType {
    public static func createFaithfulModule(service: Service) -> UIViewController {
        let view: FaithfulViewType = FaithfulViewController()
        let presenter: FaithfulPresenterType & FaithfulInteractorOutputsType = FaithfulPresenter()
        let interactor: FaithfulInteractorInputsType = FaithfulInteractor()
        let wireframe: FaithfulWireframeType = FaithfulWireframe()

        view.presenter = presenter
        presenter.service = service
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter

        if let view = view as? FaithfulViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
