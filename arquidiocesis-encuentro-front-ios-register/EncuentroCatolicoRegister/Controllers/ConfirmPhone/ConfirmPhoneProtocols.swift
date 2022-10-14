import Foundation
import UIKit

protocol ConfirmPhoneViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ConfirmPhonePresenterProtocol? { get set }
    
    func mostrarMSG(dtcAlerta: [String: String])
}

protocol ConfirmPhoneWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createConfirmPhoneModule(usuario: UserRegister) -> UIViewController
    
    func cancelar(controller: UIViewController)
    func returnToLogin(controller: UIViewController)
    func cambiarNumero(usuario: UserRegister, controller : UIViewController)
}

protocol ConfirmPhonePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ConfirmPhoneViewProtocol? { get set }
    var interactor: ConfirmPhoneInteractorInputProtocol? { get set }
    var wireFrame: ConfirmPhoneWireFrameProtocol? { get set }
    var controller: UIViewController! { get set }
    var codigo: String! { get set }
    var viewView: UIView! { get set }
    
    func viewDidLoad(txtNumber1: UITextField, txtNumber2: UITextField, txtNumber3: UITextField, txtNumber4: UITextField, txtNumber5: UITextField, txtNumber6: UITextField)
    func hideKeyBoard(view: UIView)
    func reenviarCodigo(user: UserRegister)
    func cambiarNumero(usuario: UserRegister, controller : UIViewController)
    func crearCuenta(user: UserRegister, newCode: String)
    func cancelar(controller: UIViewController)
    func politicas()
}

protocol ConfirmPhoneInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresConfirm, user: UserRegister?)
}

protocol ConfirmPhoneInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ConfirmPhoneInteractorOutputProtocol? { get set }
    var localDatamanager: ConfirmPhoneLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ConfirmPhoneRemoteDataManagerInputProtocol? { get set }
    
    func reenviarCodigo(user: UserRegister)
    func crearCuenta(user: UserRegister, codigo: String)
}

protocol ConfirmPhoneDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol ConfirmPhoneRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ConfirmPhoneRemoteDataManagerOutputProtocol? { get set }
    
    func reenviarCodigo(user: UserConfirmarCodigo)
    func validaCodigo(user: UserRegister, codigo: String)
}

protocol ConfirmPhoneRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func callbackResponse(respuesta: ResponseConfirm?, error: ErroresServidorConfirm?, user: UserRegister?)
}

protocol ConfirmPhoneLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
