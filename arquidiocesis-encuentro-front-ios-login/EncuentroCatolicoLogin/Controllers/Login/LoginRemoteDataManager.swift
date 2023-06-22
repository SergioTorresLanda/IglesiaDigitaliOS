import Foundation

class LoginRemoteDataManager:LoginRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?
    
    //    #if Dev
    //         let API = "https://auth.arquidiocesis.mx"
    //    #else
    //        let API = "https://zvxa775yh8.execute-api.us-east-1.amazonaws.com/qa"
    //    #endif
    
    func login(user: UserLogin) {
        print("remote login")

        guard let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/login") else {
            print("Error formando url")
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorInterno, user: user)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(user) else {
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorInterno, user: user)
            return
        }
        
        request.httpBody = cuerpo
        
        print("🚧  -->>  user login: ", user)
        print("🚧  -->>  endpoint login: ", endpoint)
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("->  respuesta Status Code LOGIN: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorServidor, user: user)
                return
            }
            guard let allData = data else { return }
            let outputStr  = String(data: allData, encoding: String.Encoding.utf8) as String?
            print("-->✅  LOGIN Response ->  ", outputStr as Any)
            
          
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                UserDefaults.standard.synchronize()
                let defaults = UserDefaults.standard
                defaults.setValue(true, forKey: "isUserLogged")
                
                guard let dataRes = data, let resp: RespuestaServidor = try? JSONDecoder().decode(RespuestaServidor.self, from: dataRes) else {
                    return
                }
                DAKeychain.shared["miIglesia"] = user.password
//                defaults.setValue(true, forKey: "biometricEnable")
                defaults.set(resp.AuthenticationResult.RefreshToken, forKey: "refToken")
                defaults.set(resp.AuthenticationResult.AccessToken, forKey: "accToken")
                defaults.set(resp.AuthenticationResult.IdToken, forKey: "idToken")
                let middleNameValue = resp.UserAttributes.middle_name ?? ""
                defaults.setValue(resp.UserAttributes.id, forKey: "id")
                defaults.setValue(resp.UserAttributes.name + " " + resp.UserAttributes.last_name + " " + middleNameValue, forKey: "nombre")
                defaults.setValue(resp.UserAttributes.name, forKey: "OnlyName")
                defaults.setValue(resp.UserAttributes.phone_number, forKey: "telefono")
                defaults.setValue(resp.UserAttributes.email, forKey: "email")
                defaults.setValue(resp.UserAttributes.role, forKey: "role")
                defaults.setValue(resp.UserAttributes.profile, forKey: "profile")
                
                let autoLogin = UserDefaults.standard.bool(forKey: "autoLogin")
                if !autoLogin {
                    defaults.setValue(resp.UserAttributes.email, forKey: "emailForBiometric")
                }
                
                let idUser = defaults.integer(forKey: "id")
                
                guard let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/detail/\(idUser)") else {
                    print("Error formando url")
                    return
                }
                
                var request = URLRequest(url: endpoint)
                let tksession = UserDefaults.standard.string(forKey: "idToken")
                request.httpMethod = "GET"
                request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
                let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    //print("->  respuesta Status Code: ", response as Any)
                    //print("->  error: ", error as Any)
                    if error != nil {
                        print("Hubo un error 051")
                        return
                    }
                    
                    do {
                        if data != nil {
                            let contResponse : ProfileDetailImgH = try JSONDecoder().decode(ProfileDetailImgH.self, from: data!)
                            
                            let forRegister = contResponse.data?.User?.life_status
                            
                            let jobInsert = LifeStatusComponents(id: forRegister?.id, name: forRegister?.name)
                            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: jobInsert, requiringSecureCoding: false)
                            defaults.set(encodedData, forKey: "GoProfile")
                            let locationComponentsModules = contResponse.data?.User?.location_modules?.first?.modules
                            getSNToken()
                            switch contResponse.data?.User?.profile {
                            case "DEVOTED_ADMIN":
                                if ((locationComponentsModules?.contains{ $0 == "SOS"}) == true){
                                    UserDefaults.standard.setValue(true, forKey: "isComm")
                                }else{
                                    UserDefaults.standard.setValue(false, forKey: "isComm")
                                }
                            case "COMMUNITY_RESPONSIBLE", "COMMUNITY_ADMIN", "COMMUNITY_MEMBER":
                                UserDefaults.standard.set(contResponse.data?.User?.location_modules?.first?.id, forKey: "CommunityId")
                            default:
                                break
                            }
                        }
                        
                    }catch{
                        print("error al obtener detalle del usuario", error.localizedDescription)
                    }
                    
                }
                tarea.resume()
                
                self.remoteRequestHandler?.callbackResponse(respuesta: ResponseLogin(msg: nil, error_code: 0), error: nil, user: user)
            }else{
                guard let allData = data else { return }
                
                guard let respError: ServerErrors = try? JSONDecoder().decode(ServerErrors.self, from: allData) else {
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorServidor, user: user)
                    return
                }
                LoginPresenter.strError = respError.error
                if respError.code ==  107{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.usuarioPasswordIncorrecto, user: user)
                } else if respError.code == 105{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorServidor, user: user)
                }else if respError.code == 103{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.usuarioNoExiste, user: user)
                } else {
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorLogin.ErrorServidor, user: user)
                }
            }
        }
        tarea.resume()
    }
    
}
