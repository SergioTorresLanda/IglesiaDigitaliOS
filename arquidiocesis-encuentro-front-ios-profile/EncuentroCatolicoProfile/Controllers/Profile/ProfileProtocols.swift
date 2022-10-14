import Foundation
import UIKit

protocol ProfileViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ProfilePresenterProtocol? { get set }
    func mostrarMSG(dtcAlerta: [String:String])
    func mostrarInfo(dtcAlerta: [String:String]?, user: UserRespProfile?)
    func showOffice(offices: Array<ActivitiesResponse>)
    func showCongregations(congregation: CongregationsResponse)
    func showLifeStates(lifeStates: StatesResponse)
    func showTopics(topics: TopicsResponse)
    func showError(error: String)
    func showRegisterResponse(response: RegisterPriestResponse)
    func showUserInfo(user: UserRespProfile)
}

protocol ProfileWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    func showConfiguraciones()
    func showDonaciones(navegationController: UINavigationController)
    func showInicio()
    func showAyuda()
    func showPerfil()
    func pushToRegister(navegationController: UINavigationController)
}

protocol ProfilePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    var wireFrame: ProfileWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func configuracionesActionc()
    func donacionesAction(navegationController: UINavigationController)
    func calendarioAction()
    func guardarAction(cel: String, fecha: String, email: String, edoCivil: String)
    func edoCivilAction()
    func inicioAction()
    func ayudaAction()
    func perfilAction()
    func getOffice()
    func getCongregations()
    func getLifeStates()
    func getTopics()
    func cargarDatosUsuario()
    func cerrarSesion()
    func backToLogin()
    func postRegisterPriest(request: RegisterPriestRequest)
    
    func showSoySacerdotecontroller(navegationController: UINavigationController)
}

protocol ProfileInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresProfile)
    func responseOffice(result: Result<Array<ActivitiesResponse>,ErrorEncuentro>)
    func responseCongregations(result: Result<CongregationsResponse,ErrorEncuentro>)
    func responseLifeStates(result: Result<StatesResponse,ErrorEncuentro>)
    func responseTopics(result: Result<TopicsResponse,ErrorEncuentro>)
    func respondeRegister(result: Result<RegisterPriestResponse,ErrorEncuentro>)
    func obtieneRespuetaUsuario(errores: ErroresServidorProfile, user: UserRespProfile?)
}

protocol ProfileInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol? { get set }
    func cargarDatosPersona()
    func sendLogoutRequest()
    func cargarInformacion()
    func guardarinformacion(cel: String, fecha: String, email: String, edoCivil: String)
    func requestOffice()
    func requestlifeStates()
    func requestTopics()
    func requestCongregations()
    func postRegisterPriest(request: RegisterPriestRequest)
}

protocol ProfileDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGERç
    var presenter: ProfilePresenterProtocol?  { get set }
    
}

protocol ProfileRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    func cargarInformacion()
    func guardarinformacion(cel: String, fecha: String, email: String, edoCivil: String)
}

protocol ProfileRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ProfileLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
