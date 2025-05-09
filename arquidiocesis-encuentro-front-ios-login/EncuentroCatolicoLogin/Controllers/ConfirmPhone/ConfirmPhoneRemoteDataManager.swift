import Foundation

class ConfirmPhoneRemoteDataManager:ConfirmPhoneRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ConfirmPhoneRemoteDataManagerOutputProtocol?
    func reenviarCodigo(user: UserConfirmarCodigo) {
        //print("->>  🎾 user: ", user.username)
        
        let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/resend_code")!
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(user) else {
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorInterno, user: nil)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("-> ☘️ respuesta Status Code: ", response as Any)
            //print("->  ☘️🎃 error: ", error as Any)
            guard let allData = data else { return }
            let outputStr  = String(data: allData, encoding: String.Encoding.utf8) as String?
            //print("-->✅  Response ->  ", outputStr as Any)
            
            if error != nil {
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorServidor, user: nil)
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.remoteRequestHandler?.callbackResponse(respuesta: ResponseConfirm(UserConfirmed: true, UserSub: ""), error: ErroresServidorConfirm.OkReenviarCodigo, user: nil)
            } else {
              //  self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorServidor, user: nil)
            }
            
        }
        tarea.resume()
    }
    
    func validaCodigo(user: UserRegister, codigo: String) {
        print("😁  😁 Comfirmacion user: ", user)
        
        guard let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/confirm") else {
            print("Error formando url")
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorInterno, user: user)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(BodyConfirm(username: user.username, code: codigo)) else {
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorInterno, user: user)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error 056")
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorServidor, user: user)
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                
                let defaults = UserDefaults.standard
                defaults.setValue(user.name + " " + user.last_name + " " + user.middle_name, forKey: "nombre")
                defaults.setValue(user.phone_number, forKey: "telefono")
                defaults.setValue(user.email, forKey: "email")
                defaults.setValue(user.email, forKey: "emailForBiometric")
                
                self.remoteRequestHandler?.callbackResponse(respuesta: ResponseConfirm(UserConfirmed: true, UserSub: ""), error: ErroresServidorConfirm.Ok, user: user)
            } else if (response as! HTTPURLResponse).statusCode == 500 {
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorCodigo, user: user)
            } else {
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidorConfirm.ErrorServidor, user: user)
            }
            
        }
        tarea.resume()
    }
    
}

extension String {
    func isValidEmailSP() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
