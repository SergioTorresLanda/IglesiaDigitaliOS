import Foundation
import UIKit
import EncuentroCatolicoHome

open class Vista1WireFrame: Vista1WireFrameProtocol {

    open class func createModule() -> UIViewController {
        let navController = Vista1View(nibName: "Vista1View", bundle: Bundle(for: Vista1View.self))
        let view = navController
        let presenter: Vista1PresenterProtocol & Vista1InteractorOutputProtocol = Vista1Presenter()
        let interactor: Vista1InteractorInputProtocol & Vista1RemoteDataManagerOutputProtocol = Vista1Interactor()
        let remoteDataManager: Vista1RemoteDataManagerInputProtocol = Vista1RemoteDataManager()
        let wireFrame: Vista1WireFrameProtocol = Vista1WireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return navController
    }
    
    func omitir(controller: UIViewController) {
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .fullScreen
        controller.present(view, animated: true)
    }
    
    func siguiente(controller: UIViewController) {
        let view = Vista2WireFrame.createModule()
        controller.navigationController?.pushViewController(view, animated: true)
    }
    
}
