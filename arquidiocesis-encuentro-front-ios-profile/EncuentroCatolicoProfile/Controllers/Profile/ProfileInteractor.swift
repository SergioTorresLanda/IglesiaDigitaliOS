import Foundation

class ProfileInteractor: ProfileInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    var localDatamanager: ProfileLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileRemoteDataManagerInputProtocol?
    
    func cargarDatosPersona() {
        
        guard let endpoint: URL = URL(string: "https://auth.arquidiocesis.mx/user/info") else {
            print("Error formando url")
            self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(cargarInfoUserDefault()) else {
            self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                return
            }
            
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                let userProfile: UserRespProfile? = try? JSONDecoder().decode(UserRespProfile.self, from: data!)
                
                self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.OK, user: userProfile)
                
            } else {
                //let resp = try? JSONDecoder().decode([String:String].self, from: data!)
                
                self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            }
            
        }
        tarea.resume()
        
    }
    
    func sendLogoutRequest() {
        
        guard let endpoint: URL = URL(string: "https://auth.arquidiocesis.mx/user/logout") else {
            print("Error formando url")
            self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(cargarInfoUserDefault()) else {
            self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Hubo un error")
                return
            }
            
            
            if (response as! HTTPURLResponse).statusCode == 200 {
              
                
            } else {
                self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            }
            
        }
        tarea.resume()
        
    }
    
    func cargarInformacion() {
        remoteDatamanager?.cargarInformacion()
    }
    
    private func cargarInfoUserDefault() -> UserProfile {
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email") ?? ""
        return UserProfile(username: email)
    }
    
    func guardarinformacion(cel: String, fecha: String, email: String, edoCivil: String) {
        if cel.trimmingCharacters(in: .whitespaces) == "" || fecha.trimmingCharacters(in: .whitespaces) == "" || email.trimmingCharacters(in: .whitespaces) == "" || edoCivil == "" {
            presenter?.respuestaValidacion(error: ErroresProfile.DatosVacios)
        } else {
            
            if cel.count < 10 {
                presenter?.respuestaValidacion(error: ErroresProfile.CelDigitos)
                return
            }
            
            if !isValidEmailAddress(emailAddressString: email) {
                presenter?.respuestaValidacion(error: ErroresProfile.EmailIncorrecto)
                return
            }
            
            remoteDatamanager?.guardarinformacion(cel: cel, fecha: fecha, email: email, edoCivil: edoCivil)
        }
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        
        return  returnValue
    }

    func postRegisterPriest(request: RegisterPriestRequest) {
        RequestManager.shared.perform(route: RegisterRouter.register(request: request)) {
            [weak self] (result, _) in
            self?.presenter?.respondeRegister(result: result)
        }
    }
    
    func requestOffice() {
        RequestManager.shared.perform(route: RegisterRouter.activities) { [weak self] (result: Result<Array<ActivitiesResponse>, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseOffice(result: result)
        }
    }
    func requestCongregations() {
        RequestManager.shared.perform(route: RegisterRouter.congregations) { [weak self] (result: Result<CongregationsResponse, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseCongregations(result: result)
        }
    }
    
    func requestlifeStates() {
        RequestManager.shared.perform(route: RegisterRouter.states) { [weak self] (result: Result<StatesResponse, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseLifeStates(result: result)
        }
    }
    
    func requestTopics() {
        RequestManager.shared.perform(route: RegisterRouter.topics) { [weak self] (result: Result<TopicsResponse, ErrorEncuentro>, header: Dictionary<String, Any>?) in
            self?.presenter?.responseTopics(result: result)
        }
    }
}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
