import Foundation

class ProfileInfoInteractor: ProfileInfoInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: ProfileInfoInteractorOutputProtocol?
    var localDatamanager: ProfileInfoLocalDataManagerInputProtocol?
    var remoteDatamanager: ProfileInfoRemoteDataManagerInputProtocol?

    let API = "\(APIType.shared.Auth())"
    let APIImage = "\(APIType.shared.User())"

    
    func postImgBase64(elementID: Int, type: String, filename: String, contentBase64: String) {
        guard let apiURL = URL(string: APIImage + "/s3-upload") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : Any] = [
            "element_id" : elementID,
            "type" : type,
            "filename" : filename,
            "content" : contentBase64
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                let dataResp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                let contentResponse : UploadImageData = try JSONDecoder().decode(UploadImageData.self, from: data!)
                self.presenter?.responseUpload64(responseCode: response as! HTTPURLResponse, responseData: contentResponse)
                print(dataResp)
                print(contentResponse)
                
            }catch{
                print("error al postear imagen", error.localizedDescription)
                APIType.shared.refreshToken()
            }
            
        }
        
        tarea.resume()
    }
    
    func getUserDetail() {
        
        let defaults = UserDefaults.standard
        
        let idUser = defaults.integer(forKey: "id")
        print(idUser)
        guard let endpoint: URL = URL(string: "\(API)/user/detail/\(idUser)") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : ProfileDetailImg = try JSONDecoder().decode(ProfileDetailImg.self, from: data!)
                    print(contResponse)
                    print(response)
                    self.presenter?.reponseDetailUser(responseCode: response as! HTTPURLResponse, dataResponse: contResponse)
                }
                
            }catch{
                print("error al obtener detalle del usuario", error.localizedDescription)
            }
            
        }
        tarea.resume()
    }
    
    func getAllUserData() {
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print(idUser)
        guard let endpoint: URL = URL(string: "\(API)/user/detail/\(idUser)") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : DetailProfile = try JSONDecoder().decode(DetailProfile.self, from: data!)
                    print(contResponse, "####")
                    self.presenter?.reponseAllDetailUser(responseCode: response as! HTTPURLResponse, dataResponse: contResponse)
                    
                }
                
            }catch{
                print("error al obtener detalle del usuario", error.localizedDescription)
            }
            
        }
        tarea.resume()
    }
    
    func cargarDatosPersona() {
        guard let endpoint: URL = URL(string: "\(API)/user/info") else {
            print("Error formando url")
            presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(cargarInfoUserDefault()) else {
            presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                let userProfile: UserRespProfile? = try? JSONDecoder().decode(UserRespProfile.self, from: data!)
                let user = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print("esta es la data del user:", user)
                
                self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.OK, user: userProfile)
                
            } else {
                // let resp = try? JSONDecoder().decode([String:String].self, from: data!)
                APIType.shared.refreshToken()
                self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            }
        }
        tarea.resume()
    }
    
    func getPrefixCatalog(code: String) {
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print(idUser)
        guard let endpoint: URL = URL(string: "\(APIImage)/catalog/religious-prefixes?life-state=\(code)") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : PrefixResponse = try JSONDecoder().decode(PrefixResponse.self, from: data!)
                    self.presenter?.onSuccessPrefix(data: contResponse, response: (response as! HTTPURLResponse))
                }
                
            }catch{
                print("error al obtener detalle del usuario", error.localizedDescription)
                self.presenter?.onFailPrefix(error: error)
                APIType.shared.refreshToken()
            }
            
        }
        tarea.resume()
    }
    
    func sendLogoutRequest() {
        guard let endpoint: URL = URL(string: "\(API)/user/logout") else {
            print("Error formando url")
            presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(cargarInfoUserDefault()) else {
            presenter?.obtieneRespuetaUsuario(errores: ErroresServidorProfile.ErrorServidor, user: nil)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { _, response, error in
           
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)

            if error != nil {
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
            } else {
                APIType.shared.refreshToken()
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
        
        return returnValue
    }
    
    func postRegisterPriest(request: RegisterPriestRequest) {
        RequestManager.shared.perform(route: RegisterRouter.register(request: request)) {
            [weak self] result, _ in
            self?.presenter?.respondeRegister(result: result)
        }
    }
    
    func postDiacono(request: ProfileDiacono) {
        //        RequestManager.shared.perform(route: RegisterRouter.profileDiacono(request: request)) {
        //            [weak self] result, _ in
        //            self?.presenter?.responseDiacono(result: result)
        //        }
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(API)/" + "user/update" ) else {
            print("Error formando url")
            self.presenter?.responsePriest(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                return
            }
            print(response)
            if (response as! HTTPURLResponse).statusCode == 200 {
                //self.presenter?.responseDiac(errores: ServerErrors.OK, data: nil)
                self.presenter?.successPostDiacano()
            }else{
                self.presenter?.failPostDiacano()
                APIType.shared.refreshToken()
                //self.presenter?.responseDiac(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    
    func postLaicoReligioso(request: ProfileCongregation) {
//        RequestManager.shared.perform(route: RegisterRouter.profileDiacono(request: request)) {
//            [weak self] result, _ in
//            self?.presenter?.responseDiacono(result: result)
//        }
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(API)/" + "user/update" ) else {
            print("Error formando url")
            self.presenter?.responsePriest(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
       
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            print(response)
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.successPostLaicoReligioso()

            }else{
                APIType.shared.refreshToken()
                self.presenter?.failPostLaicoReligioso()
            }
        }
        tarea.resume()
    }
    
    func postSacerdote(request: ProfilePriest) {
        //        RequestManager.shared.perform(route: RegisterRouter.profilePriest(request: request)) {
        //            [weak self] result, _ in
        //            self?.presenter?.responseSacerdote(result: result)
        //        }
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(API)/" + "user/update" ) else {
            print("Error formando url")
            self.presenter?.responsePriest(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responsePriest(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePriest(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func postState(request: ProfileState) {
        RequestManager.shared.perform(route: RegisterRouter.profileState(request: request)) {
            [weak self] result, _ in
            self?.presenter?.responseState(result: result)
        }
    }
    
    func postCongregation(request: ProfileCongregation) {
        RequestManager.shared.perform(route: RegisterRouter.profileCongregation(request: request)) {
            [weak self] result, _ in
            self?.presenter?.responseCongregation(result: result)
        }
    }
    
    func requestOffice() {
        RequestManager.shared.perform(route: RegisterRouter.activities) { [weak self] (result: Result<Array<ActivitiesResponse>, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseOffice(result: result)
        }
    }
    
    func requestCongregations() {
        RequestManager.shared.perform(route: RegisterRouter.congregations) { [weak self] (result: Result<CongregationsResponse, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseCongregations(result: result)
        }
    }
    
    func requestDetalles() {
        RequestManager.shared.perform(route: RegisterRouter.detail) { [weak self] (result: Result<DetailProfile, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseDetalles(result: result)
            print("KK: \(result)")
        }
    }
    
    func requestlifeStates() {
        RequestManager.shared.perform(route: RegisterRouter.states) { [weak self] (result: Result<StatesResponse, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseLifeStates(result: result)
        }
    }
    
    func requestTopics() {
        RequestManager.shared.perform(route: RegisterRouter.topics) { [weak self] (result: Result<TopicsResponse, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseTopics(result: result)
        }
    }
    
    func requestServices() {
        RequestManager.shared.perform(route: RegisterRouter.service) { [weak self] (result: Result<ServiceResponse, ErrorEncuentro>, _: Dictionary<String, Any>?) in
            self?.presenter?.responseServices(result: result)
        }
    }
    
    func deleteAccount(email: String) {
           let apiURL = URL(string: "\(APIType.shared.Auth())/user/delete?email=\(email)")
            
        var request = URLRequest(url: apiURL!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let tksession = UserDefaults.standard.string(forKey: "idToken")
            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //print("->  request 🤡: ", request as Any)
                //print("->  respuesta Status Code: ", response as Any)
                //print("->  error: ", error as Any)
                guard let allData = data else { return }
                let outputStr  = String(data: allData, encoding: String.Encoding.utf8) as String?
                //print("->  outputStr: ", outputStr as Any)
                if error != nil {
                    print("Hubo un error")
                    return
                }
                if (response as! HTTPURLResponse).statusCode == 200 {
                    self.presenter?.responseDeleteByEmail(status: true)
                }else{
                    self.presenter?.responseDeleteByEmail(status: false)
                }
        }
            task.resume()
        }
}

extension ProfileInfoInteractor: ProfileInfoRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
