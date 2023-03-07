import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    
    func mostrarMSG(dtcAlerta: [String:String])
    func retryRegister(dtcAlerta: [String:String])
    func hideLoading()
    func openHome()
}

protocol LoginWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createModule(version: Double, forceUpdate: Bool) -> UIViewController
    
    func openCreateAcount(controlador: UIViewController)
    func loginInvitado(controller: UIViewController)
    func openForgotModule(controlador: UIViewController)
}

protocol LoginPresenterProtocol: AnyObject {
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

protocol LoginInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresLogin)
}

protocol LoginInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func login(user: String, password: String)
}

protocol LoginDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    func login(user: UserLogin)
}

protocol LoginRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func callbackResponse(respuesta: ResponseLogin?, error: ErroresServidorLogin?, user: UserLogin)
}

protocol LoginLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
