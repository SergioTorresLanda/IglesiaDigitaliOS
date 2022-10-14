import Foundation
import UIKit

class ProfilePresenter {
    // MARK: Properties

    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    var dataManager = EditionPromisseDataManager.shareInstance

    func postRegisterPriest(request: RegisterPriestRequest) {
        interactor?.postRegisterPriest(request: request)
    }

    func respondeRegister(result: Result<RegisterPriestResponse, ErrorEncuentro>) {
        print(result)
        switch result {
        case let .success(response):
            view?.showRegisterResponse(response: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
            print(error)
        }
    }

    func getCongregations() {
        interactor?.requestCongregations()
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

    func responseOffice(result: Result<Array<ActivitiesResponse>, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showOffice(offices: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
        }
    }

    func responseCongregations(result: Result<CongregationsResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showCongregations(congregation: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
        }
    }

    func responseLifeStates(result: Result<StatesResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showLifeStates(lifeStates: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
        }
    }

    func responseTopics(result: Result<TopicsResponse, ErrorEncuentro>) {
        switch result {
        case let .success(response):
            view?.showTopics(topics: response)
        case let .failure(error):
            view?.showError(error: error.errorDescription)
        }
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
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
        interactor?.cargarInformacion()
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
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
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
}
