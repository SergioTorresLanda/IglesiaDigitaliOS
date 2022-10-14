import Foundation
import UIKit
import EncuentroCatolicoHome

open class Vista2WireFrame: Vista2WireFrameProtocol {

    open class func createModule() -> UIViewController {
        let navController = Vista2View(nibName: "Vista2View", bundle: Bundle(for: Vista2View.self))
        let view = navController
        let presenter: Vista2PresenterProtocol & Vista2InteractorOutputProtocol = Vista2Presenter()
        let interactor: Vista2InteractorInputProtocol & Vista2RemoteDataManagerOutputProtocol = Vista2Interactor()
        let remoteDataManager: Vista2RemoteDataManagerInputProtocol = Vista2RemoteDataManager()
        let wireFrame: Vista2WireFrameProtocol = Vista2WireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func siguiente(controller: UIViewController) {
        #warning("ESTO DE QUI NO SE ENTIENDE LA LOGICA")
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
//        let view = LoginRouter.createModule()
//        view.modalPresentationStyle = .fullScreen
//        controller.present(view, animated: true, completion: nil)
//        
    }
    
}
