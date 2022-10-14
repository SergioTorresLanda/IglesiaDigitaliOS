import Foundation
import UIKit

protocol Vista2ViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: Vista2PresenterProtocol? { get set }
}

protocol Vista2WireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    
    func siguiente(controller: UIViewController)
}

protocol Vista2PresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: Vista2ViewProtocol? { get set }
    var interactor: Vista2InteractorInputProtocol? { get set }
    var wireFrame: Vista2WireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func siguiente(controller: UIViewController)
}

protocol Vista2InteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol Vista2InteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: Vista2InteractorOutputProtocol? { get set }
    var localDatamanager: Vista2LocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: Vista2RemoteDataManagerInputProtocol? { get set }
    
    func guarda()
}

protocol Vista2DataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol Vista2RemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: Vista2RemoteDataManagerOutputProtocol? { get set }
}

protocol Vista2RemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol Vista2LocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
