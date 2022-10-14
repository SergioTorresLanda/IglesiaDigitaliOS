import Foundation
import UIKit

open class DonationsRouter: DonativoWireFrameProtocol {

    open class func createModule() -> UIViewController {
        let navController = DonativoView(nibName: "DonativoView", bundle: Bundle(for: DonativoView.self))
        let view = navController
        let presenter: DonativoPresenterProtocol & DonativoInteractorOutputProtocol = DonativoPresenter()
        let interactor: DonativoInteractorInputProtocol & DonativoRemoteDataManagerOutputProtocol = DonativoInteractor()
        let localDataManager: DonativoLocalDataManagerInputProtocol = DonativoLocalDataManager()
        let remoteDataManager: DonativoRemoteDataManagerInputProtocol = DonativoRemoteDataManager()
        let wireFrame: DonativoWireFrameProtocol = DonationsRouter()
        
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
    
}
