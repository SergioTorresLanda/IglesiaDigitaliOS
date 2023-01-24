import Foundation
import UIKit

open class ProfileInfoRouter: ProfileInfoWireFrameProtocol {

    func pushToConfig(from contoller: AnyObject) {
        AdminRouter.getController(from: contoller)
    }
    
    
    open class func createModule() -> UIViewController {
        let navController = ProfileInfoView(nibName: "ProfileInfoView", bundle: Bundle(for: ProfileInfoView.self))
        let view = navController
        let presenter: ProfileInfoPresenterProtocol & ProfileInfoInteractorOutputProtocol = ProfileInfoPresenter()
        let interactor: ProfileInfoInteractorInputProtocol & ProfileInfoRemoteDataManagerOutputProtocol = ProfileInfoInteractor()
        let localDataManager: ProfileInfoLocalDataManagerInputProtocol = ProfileInfoLocalDataManager()
        let remoteDataManager: ProfileInfoRemoteDataManagerInputProtocol = ProfileInfoRemoteDataManager()
        let wireFrame: ProfileInfoWireFrameProtocol = ProfileInfoRouter()
        
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
    
    open class func createModuleTwo() -> UIViewController {
        let storyboard = UIStoryboard(name: "register", bundle: Bundle(for: RegisterProfileViewController.self))
        let view: ProfileInfoViewProtocol = storyboard.instantiateViewController(withIdentifier: "RegisterProfileViewController") as! ProfileInfoViewProtocol
        let presenter: ProfileInfoPresenterProtocol & ProfileInfoInteractorOutputProtocol = ProfileInfoPresenter()
        let interactor: ProfileInfoInteractorInputProtocol & ProfileInfoRemoteDataManagerOutputProtocol = ProfileInfoInteractor()
        let localDataManager: ProfileInfoLocalDataManagerInputProtocol = ProfileInfoLocalDataManager()
        let remoteDataManager: ProfileInfoRemoteDataManagerInputProtocol = ProfileInfoRemoteDataManager()
        let wireFrame: ProfileInfoWireFrameProtocol = ProfileInfoRouter()
        //view.preProfile=info
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view as! UIViewController
    }
    
    func pushToRegister(navegationController: UINavigationController) {
        print("PUSH TO REGISTER SACERDOTE")
        //let registerModue = ProfileInfoRouter.createModuleTwo()
        //navegationController.pushViewController(registerModue, animated: true)
    }
    
    func showConfiguraciones() {
    
    }
    
    func showDonaciones(navegationController: UINavigationController) {
        navegationController.pushViewController(EditionPromisseMain.createModule(navigation: navegationController), animated: true)
    }
    
    func showChurchesMap(vc: UIViewController) {
        
    }

    func showInicio() {
        
    }
    
    func showAyuda() {
        
    }
    
    func showPerfil() {
        
    }
    
}
