//
//  ColaboradoresInteractor.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 05/05/21.
//

import Foundation

class AdminInteractor: ProtocolosAdminInteractorInput {
    
    var presenter: ProtocolosAdminInteractorOutput?
    
    func requestData(id: Int) {
        GetPrincipalChurch.init(id: String(id)).execute { (result) in
            self.presenter?.responseColaboradores(result)
        } onError: { (error, msg) in
            self.presenter?.isError(error: msg)
        }
        
    }
    func requestDeleteColaborador(id: Int?, email: String?, phone: String?) {
        guard let apiURL = URL(string: "\(APIType.shared.Auth())/user/delete")
        else {
            self.presenter?.responseDeleteColaborador(status: false)
            return
        }
        let defaults = UserDefaults.standard
        let tksession = defaults.string(forKey: "idToken")
        let parameterDictionary: [String : Any] = [
            "user_id" :  defaults.string(forKey: "id") ?? ""
        ]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  request 🤡: ", request as Any)
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            guard let allData = data else { return }
            let outputStr  = String(data: allData, encoding: String.Encoding.utf8) as String?
            //print("-->✅  Response ->  ", outputStr as Any)
            if error != nil {
                print("Hubo un error")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseDeleteColaborador(status: true)
            }else{
                self.presenter?.responseDeleteColaborador(status: false)
            }
        }
        task.resume()
    }
    
}
