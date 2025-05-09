import Foundation
import UIKit

class ProfileInfoPresenter {
    // MARK: Properties

    weak var view: ProfileInfoViewProtocol?
    var interactor: ProfileInfoInteractorInputProtocol?
    var wireFrame: ProfileInfoWireFrameProtocol?
    var dataManager = EditionPromisseDataManager.shareInstance

    func requestPrefixes(code: String) {
        interactor?.getPrefixCatalog(code: code)
    }
    
    func postLaicoReligioso(request: ProfileCongregation) {
        interactor?.postLaicoReligioso(request: request)
    }
    
    func successPostLaicoReligioso() {
        print("SUCCES POST LAICO")

        DispatchQueue.main.async {
            self.view?.successLaicoReligioso()
        }
    }
    
    func failPostLaicoReligioso() {
        print("FAIL POST LAICO")
        DispatchQueue.main.async {
            self.view?.failLaicoReligioso()
        }
    }
    
    func successPostDiacano() {
        DispatchQueue.main.async {
            self.view?.successDiacano()
        }
    }
    
    func failPostDiacano() {
        DispatchQueue.main.async {
            self.view?.failDiacano()
        }
    }
    
    
    func postRegisterPriest(request: RegisterPriestRequest) {
        interactor?.postRegisterPriest(request: request)
    }

    func postDiacono(request: ProfileDiacono) {
        interactor?.postDiacono(request: request)
    }

    func postSacerdote(request: ProfilePriest) {
        interactor?.postSacerdote(request: request)
    }

    func postState(request: ProfileState) {
        interactor?.postState(request: request)
    }
    func deleteAccount(email: String) {
        interactor?.deleteAccount(email: email)
    }
    func postCongregation(request: ProfileCongregation) {
        interactor?.postCongregation(request: request)
    }

    
    func onSuccessPrefix(data: PrefixResponse, response: HTTPURLResponse) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.successPrefix(data: data)
            }else{
                self.view?.failPrefix(message: "Error unknown")
            }
        }
    }
    
    func onFailPrefix(error: Error) {
        DispatchQueue.main.async {
            self.view?.failPrefix(message: error.localizedDescription)
        }
    }
    
    func respondeRegister(result: Result<RegisterPriestResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showRegisterResponse(response: response)
        case let .failure(error):
            print("::::;;;;;   respondeRegister FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
            print(error)
        }
    }

    func responseDiacono(result: Result<ResponseDiacono, ErrorEncuentro>) {
        view?.showDiaconoResponse()

    }

    func responseSacerdote(result: Result<ResponseSacerdote, ErrorEncuentro>) {
        view?.showSacerdoteResponse()
    }

    func responseState(result: Result<ResponseState, ErrorEncuentro>) {
        switch result {
        case .success(_):
            print("::::::::SUCCESS RESPONSE STATE::::: ")
            view?.showStatesResponnse()
        case .failure(let error):
            print("::::::::FAIL RESPONSE STATE::::: ")
            //view?.showError(error: error.errorDescription)
            print(error.errorDescription)
            view?.showError(error: "Ocurrió un error, contacta al administrador")
        }
        
    }
    
    func responseDeleteByEmail(status: Bool) {
        self.view?.isSuccesDelete(result: status)
    }
    
    func responseCongregation(result: Result<ResponseCongregation, ErrorEncuentro>) {
        view?.showCongregationResponse()
    }

    func getCongregations() {
        interactor?.requestCongregations()
    }

    func getDetalles() {
        interactor?.requestDetalles()
    }

    func getOffice() {
        interactor?.requestOffice()
    }

    func getLifeStates() {
        interactor?.requestlifeStates()
    }

    func getTopics() {
        interactor?.requestTopics()
    }

    func getServices() {
        interactor?.requestServices()
    }

    func responseOffice(result: Result<Array<ActivitiesResponse>, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showOffice(offices: response)
        case let .failure(error):
            print("::::;;;;;   responseOffice FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }

    func responseCongregations(result: Result<CongregationsResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showCongregations(congregation: response)
        case let .failure(error):
            print("::::;;;;;   respondeCongregations FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }

    func responseDetalles(result: Result<DetailProfile, ErrorEncuentro>) {
        print("Volvio de responseDetalles")
        switch result {
        case let .success(response):
            view?.showDetalles(detail: response)
        case let .failure(error):
            print("::::;;;;;   respondeDetalles FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }

    func responseLifeStates(result: Result<StatesResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showLifeStates(lifeStates: response)
        case let .failure(error):
            print("::::;;;;;   responseLifeStates FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }

    func responseTopics(result: Result<TopicsResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showTopics(topics: response)
        case let .failure(error):
            print("::::;;;;;   responseTopics FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }

    func responseServices(result: Result<ServiceResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showServices(services: response)
        case let .failure(error):
            print("::::;;;;;   responseServices FAIL  :::::::;;;;;;")
            view?.showError(error: error.errorDescription)
        }
    }
}

extension ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    func isSuccesDelete(result: Bool) {
        ()
    }
    
    func showConfigController() {
        if let view = view {
            wireFrame?.pushToConfig(from: view)
        }
    }
    
    func donacionesAction(navegationController: UINavigationController) {
        wireFrame?.showDonaciones(navegationController: navegationController)
    }

    func showSoySacerdotecontroller(navegationController: UINavigationController) {
        wireFrame?.pushToRegister(navegationController: navegationController)
    }

    func obtieneRespuetaUsuario(errores: ErroresServidorProfile, user: UserRespProfile?) {
        DispatchQueue.main.async {
            switch errores {
            case .ErrorInterno:
                let msg = ["titulo": "Error", "cuerpo": "Error en el servidor"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo": "Error", "cuerpo": "Error en la aplicación"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .OK:
                self.view?.showUserInfo(user: user!)
            }
        }
    }

    func cargarDatosUsuario() {
        interactor?.cargarDatosPersona()
    }

    func backToLogin() {
    }

    func cerrarSesion() {
        interactor?.sendLogoutRequest()
    }

    // TODO: implement presenter methods
    func viewDidLoad() {
       // interactor?.cargarInformacion()
        //interactor?.cargarDatosPersona()
       // interactor?.requestDetalles()
        interactor?.requestServices()
        interactor?.requestOffice()
        interactor?.requestCongregations()
        interactor?.requestlifeStates()
        interactor?.requestTopics()
        
    }

    func configuracionesActionc() {
        wireFrame?.showConfiguraciones()
    }

    func calendarioAction() {
    }

    func edoCivilAction() {
    }

    func guardarAction(cel: String, fecha: String, email: String, edoCivil: String) {
        interactor?.guardarinformacion(cel: cel, fecha: fecha, email: email, edoCivil: edoCivil)
    }

    func inicioAction() {
        wireFrame?.showInicio()
    }

    func ayudaAction() {
        wireFrame?.showAyuda()
    }

    func perfilAction() {
        wireFrame?.showPerfil()
    }
    
    func uploadImageBase64(elementID: Int, type: String, filename: String, contentBase64: String) {
        interactor?.postImgBase64(elementID: elementID, type: type, filename: filename, contentBase64: contentBase64)
    }
    
    func getUserDetailP() {
        interactor?.getUserDetail()
    }
    
    func getAllUserDetail() {
        interactor?.getAllUserData()
    }
    
}

extension ProfileInfoPresenter: ProfileInfoInteractorOutputProtocol {
    func responseDiac(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            print("::::;;;;;   responseDiac FAIL  interno :::::::;;;;;;")
            view?.showError(error: "")
        case .ErrorServidor:
            print("::::;;;;;   responseDiac FAIL  servidor :::::::;;;;;;")
            view?.showError(error: "")
        case .OK:
            view?.showDiaconoResponse()
        }
    }
    
    func responsePriest(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            print("::::;;;;;   responsePriest FAIL  interno :::::::;;;;;;")
            view?.showError(error: "Error Interno")
        case .ErrorServidor:
            print("::::;;;;;   responsePriest FAIL  servidor :::::::;;;;;;")
            view?.showError(error: "Error Servidor")
        case .OK:
            view?.showSacerdoteResponse()
        }
    }
    
    // TODO: implement interactor output methods

    func respuestaValidacion(error: ErroresProfile) {
        switch error {
        case .OK:
            let msg = ["titulo": "Correcto", "cuerpo": "Información actualizada correctamente"]
            view?.mostrarMSG(dtcAlerta: msg)
        case .DatosVacios:
            let msg = ["titulo": "Atención", "cuerpo": "Faltan campos por llenar"]
            view?.mostrarMSG(dtcAlerta: msg)
        case .CelDigitos:
            let msg = ["titulo": "Atención", "cuerpo": "El celular es a 10 digitos"]
            view?.mostrarMSG(dtcAlerta: msg)
        case .NombreMal:
            let msg = ["titulo": "Atención", "cuerpo": "Favor de escribir un nombre correcto"]
            view?.mostrarMSG(dtcAlerta: msg)
        case .EmailIncorrecto:
            let msg = ["titulo": "Atención", "cuerpo": "Favor de validar el email"]
            view?.mostrarMSG(dtcAlerta: msg)
        case .ErrorServidor:
            let msg = ["titulo": "Error", "cuerpo": "Error en el servidor"]
            view?.mostrarMSG(dtcAlerta: msg)
        }
    }
    
    func responseUpload64(responseCode: HTTPURLResponse, responseData: UploadImageData) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 201 || responseCode.statusCode == 200 {
                self.view?.succesUpload64(responseData: responseData)
            }else{
                self.view?.failUpload64()
            }
        }
    }
    
    func responseDetailUser(responseCode: HTTPURLResponse, dataResponse: ProfileDetailImg) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesGetDetailProfile(responseData: dataResponse)
            }else{
                self.view?.failGetDataProfile()
            }
        }
    }
    
    func responseAllDetailUser(responseCode: HTTPURLResponse, dataResponse: DetailProfile) {
        print("Volvio de responseAllDetailUser")
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.showDetalles(detail: dataResponse)
            }else{
                self.view?.failGetDataProfile()
            }
        }
    }
    
}
