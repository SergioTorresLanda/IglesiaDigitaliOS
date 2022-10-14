import Foundation
import UIKit

protocol Vista1ViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: Vista1PresenterProtocol? { get set }
}

protocol Vista1WireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    
    func omitir(controller: UIViewController)
    func siguiente(controller: UIViewController)
}

protocol Vista1PresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: Vista1ViewProtocol? { get set }
    var interactor: Vista1InteractorInputProtocol? { get set }
    var wireFrame: Vista1WireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func omitir(controller: UIViewController)
    func siguiente(controller: UIViewController)
}

protocol Vista1InteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol Vista1InteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: Vista1InteractorOutputProtocol? { get set }
    var localDatamanager: Vista1LocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: Vista1RemoteDataManagerInputProtocol? { get set }
    
    func guardar()
}

protocol Vista1DataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol Vista1RemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: Vista1RemoteDataManagerOutputProtocol? { get set }
}

protocol Vista1RemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol Vista1LocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
