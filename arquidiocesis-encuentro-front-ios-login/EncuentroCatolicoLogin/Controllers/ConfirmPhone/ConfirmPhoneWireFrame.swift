import Foundation
import UIKit
import EncuentroCatolicoHome

class ConfirmPhoneWireFrame: ConfirmPhoneWireFrameProtocol {
    
    class func createConfirmPhoneModule(usuario: UserRegister) -> UIViewController {
        let navController = ConfirmPhoneViewController(nibName: "ConfirmPhoneViewController", bundle: Bundle(for: ConfirmPhoneViewController.self))
        let view = navController
        let presenter: ConfirmPhonePresenterProtocol & ConfirmPhoneInteractorOutputProtocol = ConfirmPhonePresenter()
        let interactor: ConfirmPhoneInteractorInputProtocol & ConfirmPhoneRemoteDataManagerOutputProtocol = ConfirmPhoneInteractor()
        let remoteDataManager: ConfirmPhoneRemoteDataManagerInputProtocol = ConfirmPhoneRemoteDataManager()
        let wireFrame: ConfirmPhoneWireFrameProtocol = ConfirmPhoneWireFrame()
        
        view.presenter = presenter
        view.usuario = usuario
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func cancelar(controller: UIViewController) {
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
    }
    
    func returnToLogin(controller: UIViewController) {
        let alert = UIAlertController(title: "Registro completado", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: "isNewUser")
            let Navcontroller = controller.navigationController?.viewControllers[(controller.navigationController?.viewControllers.count)! - 1]
            controller.navigationController?.popToViewController(Navcontroller!, animated: true)
        }))
        controller.present(alert, animated: true, completion: nil)
      /*  let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true) */
    }
    
    func cambiarNumero(usuario: UserRegister, controller: UIViewController) {
        /*let view = RegisterRouter.createModule(usuario)
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)*/
    }
    
}
