import Foundation
import UIKit

protocol RegisterViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: RegisterPresenterProtocol? { get set }
    func resetButton()
    func mostrarMSG(dtcAlerta: [String: String])
}

protocol RegisterWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createModule(_ user: UserRegister?) -> UIViewController
    func confirmarPhone(controlador: UIViewController, user: UserRegister)
    func cancelar(controller: UIViewController)
    func back(controller: UIViewController)
}

protocol RegisterPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: RegisterViewProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    var wireFrame: RegisterWireFrameProtocol? { get set }
    var controlador: UIViewController? { get set }
    
    func viewDidLoad(nombre: UITextField, apellido1: UITextField, apellido2: UITextField, celular: UITextField, email: UITextField, usuario: UserRegister?)
    func hideKeyBoard(view: UIView)
    func continuar(nombre: String, apellido1: String, apellido2: String, cel: String, email: String, contra1: String, contra2: String)
    func cancelar(controller: UIViewController)
    func politicas()
    
    func back(controller: UIViewController)
    
}

protocol RegisterInteractorOutputProtocol: AnyObject {
   // INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresRegister, user: UserRegister?)
}

protocol RegisterInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: RegisterInteractorOutputProtocol? { get set }
    var localDatamanager: RegisterLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol? { get set }
    
    func viewDidLoad(nombre: UITextField, apellido1: UITextField, apellido2: UITextField, celular: UITextField, email: UITextField, usuario: UserRegister?)
    func realizaValidaciones(nombre: String, apellido1: String, apellido2: String, cel: String, email: String, contra1: String, contra2: String)
}

protocol RegisterDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol RegisterRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol? { get set }
    
    func saveData(register: UserRegister)
}

protocol RegisterRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func callbackResponse(respuesta: ResponseRegister?, error: ErroresServidor?, user: UserRegister)
}

protocol RegisterLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
