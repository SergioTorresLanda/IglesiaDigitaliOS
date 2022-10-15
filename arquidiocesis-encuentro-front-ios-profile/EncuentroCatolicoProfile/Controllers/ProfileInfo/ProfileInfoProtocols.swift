import Foundation
import UIKit

protocol ProfileInfoViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ProfileInfoPresenterProtocol? { get set }
    func mostrarMSG(dtcAlerta: [String:String])
    func mostrarInfo(dtcAlerta: [String:String]?, user: UserRespProfile?)
    func showOffice(offices: Array<ActivitiesResponse>)
    func showCongregations(congregation: CongregationsResponse)
    func showLifeStates(lifeStates: StatesResponse)
    func showTopics(topics: TopicsResponse)
    func showServices(services: ServiceResponse)
    func showError(error: String)
    func showRegisterResponse(response: RegisterPriestResponse)
    func showDiaconoResponse()
    func showSacerdoteResponse()
    func showStatesResponnse()
    func showCongregationResponse()
    func showUserInfo(user: UserRespProfile)
    func showDetalles(detail: DetailProfile)
    func succesUpload64(responseData: UploadImageData)
    func failUpload64()
    func succesGetDetailProfile(responseData: ProfileDetailImg)
    func failGetDataProfile()
    
    func successLaicoReligioso() 
    func failLaicoReligioso()
    func successDiacano()
    func failDiacano()
    func successPrefix(data: PrefixResponse)
    func failPrefix(message: String)

    func isSuccesDelete(result: Bool)
}

protocol ProfileInfoWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> UIViewController
    func showConfiguraciones()
    func showDonaciones(navegationController: UINavigationController)
    func showInicio()
    func showAyuda()
    func showPerfil()
    func pushToRegister(navegationController: UINavigationController)
    func pushToConfig(from contoller: AnyObject)
}

protocol ProfileInfoPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ProfileInfoViewProtocol? { get set }
    var interactor: ProfileInfoInteractorInputProtocol? { get set }
    var wireFrame: ProfileInfoWireFrameProtocol? { get set }
    
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
    func getServices()
    func cargarDatosUsuario()
    func cerrarSesion()
    func backToLogin()
    func postRegisterPriest(request: RegisterPriestRequest)
    func postDiacono(request: ProfileDiacono)
    func postSacerdote(request: ProfilePriest)
    func postState(request: ProfileState)
    func deleteAccount(email: String)
    func isSuccesDelete(result: Bool)
    func postCongregation(request: ProfileCongregation)
    func showSoySacerdotecontroller(navegationController: UINavigationController)
    func getDetalles()
    func uploadImageBase64(elementID: Int, type: String, filename: String, contentBase64: String)
    func getUserDetailP()
    func showConfigController()
    func getAllUserDetail()
    
    func postLaicoReligioso(request: ProfileCongregation)
    func requestPrefixes(code: String) 
    
//    func successPostLaicoReligioso()
//    func failPostLaicoReligioso()
    
}

protocol ProfileInfoInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func respuestaValidacion(error: ErroresProfile)
    func responseOffice(result: Result<Array<ActivitiesResponse>,ErrorEncuentro>)
    func responseCongregations(result: Result<CongregationsResponse,ErrorEncuentro>)
    func responseLifeStates(result: Result<StatesResponse,ErrorEncuentro>)
    func responseTopics(result: Result<TopicsResponse,ErrorEncuentro>)
    func respondeRegister(result: Result<RegisterPriestResponse,ErrorEncuentro>)
    func responseDiacono(result: Result<ResponseDiacono,ErrorEncuentro>)
    func responseSacerdote(result: Result<ResponseSacerdote,ErrorEncuentro>)
    func responseState(result: Result<ResponseState,ErrorEncuentro>)
    func responseDeleteByEmail(status: Bool)
    func responseServices(result: Result<ServiceResponse,ErrorEncuentro>)
    func responseCongregation(result: Result<ResponseCongregation,ErrorEncuentro>)
    func obtieneRespuetaUsuario(errores: ErroresServidorProfile, user: UserRespProfile?)
    func responseDetalles(result: Result<DetailProfile,ErrorEncuentro>)
    func responseUpload64(responseCode: HTTPURLResponse, responseData: UploadImageData)
    func reponseDetailUser(responseCode: HTTPURLResponse, dataResponse: ProfileDetailImg)
    func responsePriest(errores: ServerErrors, data: String?)
    func responseDiac(errores: ServerErrors, data: String?)
    
    func successPostLaicoReligioso()
    func failPostLaicoReligioso()
    func successPostDiacano()
    func failPostDiacano()
    func reponseAllDetailUser(responseCode: HTTPURLResponse, dataResponse: DetailProfile)
    func onSuccessPrefix(data: PrefixResponse, response: HTTPURLResponse) 
    func onFailPrefix(error: Error)
    
}

protocol ProfileInfoInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ProfileInfoInteractorOutputProtocol? { get set }
    var localDatamanager: ProfileInfoLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProfileInfoRemoteDataManagerInputProtocol? { get set }
    func cargarDatosPersona()
    func sendLogoutRequest()
    func cargarInformacion()
    func guardarinformacion(cel: String, fecha: String, email: String, edoCivil: String)
    func requestOffice()
    func requestCongregations()
    func requestlifeStates()
    func requestTopics()
    func requestServices()
    func postRegisterPriest(request: RegisterPriestRequest)
    func postDiacono(request: ProfileDiacono)
    func postSacerdote(request: ProfilePriest)
    func postState(request: ProfileState)
    func deleteAccount(email: String)
    func postCongregation(request: ProfileCongregation)
    func requestDetalles()
    func postImgBase64(elementID: Int, type: String, filename: String, contentBase64: String)
    func getUserDetail()
    func getAllUserData()
    func getPrefixCatalog(code: String)
    
    func postLaicoReligioso(request: ProfileCongregation)
}

protocol ProfileInfoDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
    var presenter: ProfileInfoPresenterProtocol?  { get set }
    
}

protocol ProfileInfoRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: ProfileInfoRemoteDataManagerOutputProtocol? { get set }
    func cargarInformacion()
    func guardarinformacion(cel: String, fecha: String, email: String, edoCivil: String)
}

protocol ProfileInfoRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol ProfileInfoLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
