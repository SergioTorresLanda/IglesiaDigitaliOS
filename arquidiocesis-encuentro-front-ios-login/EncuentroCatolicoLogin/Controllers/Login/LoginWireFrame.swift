import Foundation
import UIKit
import EncuentroCatolicoRegister
import EncuentroCatolicoHome

open class LoginRouter: LoginWireFrameProtocol {

    open class func createModule(version: Double, forceUpdate: Bool) -> UIViewController {
        let navController = LoginView(nibName: "LoginView", bundle: Bundle(for: LoginView.self))
        navController.forceUpdate = forceUpdate
        navController.version = version
        let view = navController
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func loginInvitado(controller: UIViewController) {
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
    }
    
    func openCreateAcount(controlador: UIViewController) {
        let view = RegisterRouter.createModule(nil)
        controlador.navigationController?.pushViewController(view, animated: true)
    }
    
    func openForgotModule(controlador: UIViewController) {
        let view  = ForgotPRouter.createModule()
        controlador.navigationController?.pushViewController(view, animated: true)
        
    }
    
}
