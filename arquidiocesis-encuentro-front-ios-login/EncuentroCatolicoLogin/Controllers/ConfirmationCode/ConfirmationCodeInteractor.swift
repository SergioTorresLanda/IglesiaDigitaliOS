//
//  ConfirmationCodeInteractor.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//
import UIKit

class ConfirmationCodeInteractor: ConfirmationCodeInteractorProtocol {
    weak var presenter: ConfirmationCodePresenterProtocol?

    
    func postParams(email: String, code: String, inputP: String) {
        
//        guard let url = URL(string: "https://auth.arquidiocesis.mx/user/confirm_password")
//        else { return }
        guard let url = URL(string: "\(APIType.shared.Auth())/user/confirm_password")
        else { return }
        let parametros : [String : String] = ["username" : email, "code" : code, "password" : inputP]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        let tksession = UserDefaults.standard.string(forKey: "idToken")
//        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let tarea = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                presenter?.getStatusPost()
                guard let allData = data else { return }
                do {
                    
                    let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                    // let contentResponse : [PModelSOS] = try JSONDecoder().decode([PModelSOS].self, from: data!)
                    print(resp)
                    
                }catch{
                    APIType.shared.refreshToken()
                    print("error", error.localizedDescription)
                }
                
            } else if (response as! HTTPURLResponse).statusCode == 401 {
                APIType.shared.refreshToken()
                presenter?.getErrorPost()
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
            else {
                APIType.shared.refreshToken()
                presenter?.getErrorPost()
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
        }
        tarea.resume()
    }
    
    func postEmail2(email: String) {
        
        guard let url = URL(string: "\(APIType.shared.Auth())/user/forgot_password")
        else { return }
        let parametros : [String : String] = ["username" : email]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        presenter?.getErrorPost()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.getStatus2()
                guard let allData = data else { return }
                do {
                    
                    let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                    print(resp)
                    // let contentResponse : [PModelSOS] = try JSONDecoder().decode([PModelSOS].self, from: data!)
                    
                }catch{
                    print("error", error.localizedDescription)
                }
                
            } else {
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
        }
        tarea.resume()
    }
    
    func getUserInfo(email: String) {
        guard let url = URL(string: "\(APIType.shared.Auth())/user/info")
        else { return }
        let parametros : [String : String] = ["username" : email]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            
            guard let allData = data else { return }
            do {
                
                if (response as! HTTPURLResponse).statusCode == 200 {
                    let contentResponse = try JSONDecoder().decode(UserInfo.self, from: allData)
                    self.presenter?.successUserInfo(data: contentResponse)
                }else{
                    self.presenter?.failUserInfo()
                }
                
            }catch{
                print("Error to download user data", error, error.localizedDescription)
                self.presenter?.failUserInfo()
            }
        }.resume()
        
    }
    
}
