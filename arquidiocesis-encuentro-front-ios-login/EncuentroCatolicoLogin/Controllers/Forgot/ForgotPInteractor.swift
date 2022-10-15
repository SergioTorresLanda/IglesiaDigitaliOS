//
//  ForgotPInteractor.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

class ForgotPInteractor: ForgotInteractorProtocol {
    weak var presenter: ForgotPresenterProtocol?

    
    func postEmail(email: String) {
        
        print("Este es el user: \(email)")
//        guard let url = URL(string: "https://auth.arquidiocesis.mx/user/forgot_password")
//        else { return }
        guard let url = URL(string: "\(APIType.shared.Auth())/user/forgot_password")
        else { return }
        let parametros : [String : String] = ["username" : email]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let tksession = UserDefaults.standard.string(forKey: "idToken")
//        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            self.presenter?.getStatus(status: response as! HTTPURLResponse)
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard let allData = data else { return }
                do {
                    
                    let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                    print(resp)
                   
                }catch{
                    print("error", error.localizedDescription)
                }
               
            } else if (response as! HTTPURLResponse).statusCode == 401 {
                APIType.shared.refreshToken()
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
            else {
                
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
        }
        tarea.resume()
    }
    
}
