import Foundation

class RegisterRemoteDataManager:RegisterRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol?

    
    func saveData(register: UserRegister) {
        guard let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/signup") else {
            print("Error formando url")
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorInterno, user: register)
            return
        }
       
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        guard let cuerpo: Data = try? JSONEncoder().encode(register) else {
            self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorInterno, user: register)
            return
        }
        
        request.httpBody = cuerpo
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("----------------Services ---------------------------------")
            print("🎃  ->  endpoint: ", endpoint)
            print("->  request: ", register)
            print("->  respuesta: ", response)
            print("->  error: ", error)
            print("----------------------------------------------------------------")
        
            if error != nil {
                print("Hubo un error")
                self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorServidor, user: register)
                return
            }
           
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard let dataRes = data, let respuesta: ResponseRegister = try? JSONDecoder().decode(ResponseRegister.self, from: dataRes) else {
                    print("No se pudo parsear")
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorInterno, user: register)
                    return
                }
                   
                self.remoteRequestHandler?.callbackResponse(respuesta: respuesta, error: nil, user: register)
            } else {
                guard let resp: ServerErrors = try? JSONDecoder().decode(ServerErrors.self, from: data!) else {
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorServidor, user: register)
                    return
                }
                
                if resp.code == 101{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorInterno, user: register)
                }else if resp.code == 102{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorContrasena, user: register)
                } else if resp.code == 103{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.UsuarioSinConfirmar, user: register)
                }else if resp.code == 104{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.UsuarioExistente, user: register)
                }else if resp.code == 105{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.UsuarioExistente, user: register)
                } else{
                    self.remoteRequestHandler?.callbackResponse(respuesta: nil, error: ErroresServidor.ErrorServidor, user: register)
                }
            }
            
        }
        tarea.resume()
    }
    
}
