//
//  APIType.swift
//  EncuentroCatolicoLogin
//
//  Created by For Linko on 11/01/22.
//

import Foundation

struct respTokenValue: Codable {
    let IdToken: String
    
    init(idToken: String) {
        self.IdToken = idToken
    }
}


public class APIType {
    static var shared = APIType()
    let staged = UserDefaults.standard.string(forKey: "stage")
    var API: String = ""
    func Auth()-> String{
        
        if staged == "Qa" {
             API = "https://api.qa-iglesia-digital.com/arquidiocesis/gestion-usuarios/v1"
        }else if staged == "Prod" {
            API = "https://ppsjgdi0d9.execute-api.us-east-1.amazonaws.com/prod"
        }else {
             API = "https://auth.arquidiocesis.mx"
        }
        return API
        
    }
    
    func User()-> String{
        
        if staged == "Qa" {
            API = "https://api.qa-iglesia-digital.com/arquidi%C3%B3cesis/encuentro/v1"
        }else if staged == "Prod" {
            API = "https://fjumcvkjdg.execute-api.us-east-1.amazonaws.com/prod"
        }else {
             API = "https://api-develop.arquidiocesis.mx"
        }
        return API
        
    }
    
    func SN()-> String{
        
        if staged == "Qa" {
             API = "https://api.qa-iglesia-digital.com/arquidiocesis/red-social/v1"
        }else if staged == "Prod" {
            API = "https://os4jfceox2.execute-api.us-east-1.amazonaws.com/v1"
        }else {
             API = "https://qvh8dulob6.execute-api.us-east-1.amazonaws.com/v1"
        }
        return API
    }
    
    func refreshToken() {
           let user = UserDefaults.standard
           let Url = String(format: "\(APIType.shared.Auth())/user/refresh_tokens")
           
           guard let serviceUrl = URL(string: Url) else { return }
           let parameterDictionary: [String : Any] = [
               "refresh_token" :  user.string(forKey: "refToken") ?? ""
           ]
           var request = URLRequest(url: serviceUrl)
           request.httpMethod = "POST"
           guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
               return
           }
           request.httpBody = httpBody
           
           let session = URLSession.shared
           session.dataTask(with: request) { (data, response, error) in
               if let response = response {
                   print(response)
               }
               if let data = data {
                   do {
                       guard let resp: respTokenValue = try? JSONDecoder().decode(respTokenValue.self, from: data) else {
                           return
                       }
                       user.set(resp.IdToken, forKey: "idToken")
                       print(resp)
                   } catch {
                       print(error)
                   }
               }
           }.resume()
       }
    
}
