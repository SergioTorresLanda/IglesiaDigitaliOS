import Foundation
import UIKit

protocol LoginViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    
    func mostrarMSG(dtcAlerta: [String:String])
    func hideLoading()
}

protocol LoginWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule(version: Double, forceUpdate: Bool) -> UIViewController
    
    func openCreateAcount(controlador: UIViewController)
    func loginInvitado(controller: UIViewController)
    func openForgotModule(controlador: UIViewController)
}

protocol LoginPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    var controla: UIViewController! { get set }
    func olvidoPass(controlador: UIViewController)
    func login(user: String, password: String)
    func loginInvitado(controller: UIViewController)
    func loginSuccess()
    func crearCuenta(controlador: UIViewController)
}

protocol LoginInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresLogin)
}

protocol LoginInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func login(user: String, password: String)
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    
    func login(user: UserLogin)
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func callbackResponse(respuesta: ResponseLogin?, error: ErroresServidorLogin?, user: UserLogin)
}

protocol LoginLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
