//
//  APITypeUtils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 21/10/22.
//

import Foundation

public struct respTokenValue: Codable {
    //MARK: - Properties
    public let IdToken: String
    
    //MARK: - Life Cycle
    public init(idToken: String) {
        self.IdToken = idToken
    }
}

public class APITypeUtils {
    //MARK: - Properties
    public static var shared = APITypeUtils()
    public let staged = UserDefaults.standard.string(forKey: "stage")
    public var API: String = ""
    
    //MARK: - Methods
    public func getBasePath() -> String {
        switch staged {
        case "Qa":
            return "https://api.qa-iglesia-digital.com"
        case "Prod":
            return "https://api.iglesia-digital.com.mx"
        default:
            return ""
        }
    }
    
    public func Auth()-> String {
        switch staged {
        case "Qa", "Prod":
            API = "\(self.getBasePath())/arquidiocesis/gestion-usuarios/v1"
        default:
            API = "https://auth.arquidiocesis.mx"
        }
        
        return API
    }
    
    public func User()-> String{
        switch staged {
        case "Qa", "Prod":
            API = "\(self.getBasePath())/arquidiocesis/encuentro/v1"
        default:
            API = "https://auth.arquidiocesis.mx"
        }
        
        return API
    }
    
    public func SN()-> String{
        
        if staged == "Qa" {
            API = "https://l67w9jsvo4.execute-api.us-east-1.amazonaws.com/v1"
        }else if staged == "Prod" {
            API = "https://os4jfceox2.execute-api.us-east-1.amazonaws.com/v1"
        }else {
             API = "https://qvh8dulob6.execute-api.us-east-1.amazonaws.com/v1"
        }
        return API
    }
    
    public func refreshToken() {
           let user = UserDefaults.standard
           let Url = String(format: "\(APITypeUtils.shared.Auth())/user/refresh_tokens")
           
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
