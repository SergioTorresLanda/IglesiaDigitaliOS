import Foundation
import UIKit

open class RegisterRouter: RegisterWireFrameProtocol {

    open class func createModule(_ user: UserRegister?) -> UIViewController {
        let navController = RegisterViewController(nibName: "RegisterViewController", bundle: Bundle(for: RegisterViewController.self))
        let view = navController
        let presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterPresenter()
        let interactor: RegisterInteractorInputProtocol & RegisterRemoteDataManagerOutputProtocol = RegisterInteractor()
        let remoteDataManager: RegisterRemoteDataManagerInputProtocol = RegisterRemoteDataManager()
        let wireFrame: RegisterWireFrameProtocol = RegisterRouter()
        
        view.presenter = presenter
        view.usuario = user
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func confirmarPhone(controlador: UIViewController, user: UserRegister) {
        let view = ConfirmPhoneWireFrame.createConfirmPhoneModule(usuario: user)
        view.modalPresentationStyle = .fullScreen
        controlador.navigationController?.pushViewController(view, animated: true)
    }
    
    func cancelar(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func back(controller: UIViewController) {
        controller.navigationController?.popViewController(animated: true)
    }
    
}
