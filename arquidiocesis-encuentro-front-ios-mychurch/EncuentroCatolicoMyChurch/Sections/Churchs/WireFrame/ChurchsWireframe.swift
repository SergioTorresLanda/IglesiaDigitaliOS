//
//  ChurchsWireframe.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import UIKit

open class ChurchsWireframe: ChurchsWireframeType {
    public static func createChurchsModule() -> UIViewController {
        let view: ChurchsViewType = ChurchsViewController()
        let presenter: ChurchsPresenterType & ChurchsInteractorOutputsType = ChurchsPresenter()
        let interactor: ChurchsInteractorInputsType = ChurchsInteractor()
        let wireframe: ChurchsWireframeType = ChurchsWireframe()

        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = wireframe
        presenter.interactor = interactor
        interactor.presenter = presenter
        

        if let view = view as? ChurchsViewController {
            return view
        } else {
            return UIViewController()
        }
    }
}
