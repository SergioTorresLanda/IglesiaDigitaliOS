import Foundation
import UIKit

protocol DonativoViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: DonativoPresenterProtocol? { get set }
    
    func mostrarMSG(dtcAlerta: [String : String])
}

protocol DonativoWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
}

protocol DonativoPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: DonativoViewProtocol? { get set }
    var interactor: DonativoInteractorInputProtocol? { get set }
    var wireFrame: DonativoWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func realizarDonativo(titular: String, numeroTarjeta: String, debito: Bool, fecha: String, cvv: String, cantidad: String)
}

protocol DonativoInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func callbackPago(errores: ErroresDonativo)
}

protocol DonativoInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: DonativoInteractorOutputProtocol? { get set }
    var localDatamanager: DonativoLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DonativoRemoteDataManagerInputProtocol? { get set }
    
    func realizarDonativo(titular: String, numeroTarjeta: String, debito: Bool, fecha: String, cvv: String, cantidad: String)
}

protocol DonativoDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol DonativoRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DonativoRemoteDataManagerOutputProtocol? { get set }
}

protocol DonativoRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol DonativoLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
