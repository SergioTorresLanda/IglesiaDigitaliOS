//
//  SN.swift
//  EncuentroCatolicoLogin
//
//  Created by 4n4rk0z on 27/11/21.
//

import Foundation

public func getSNToken() {
    let idUser = UserDefaults.standard.integer(forKey: "id")
    let Url = String(format:"\(APIType.shared.SN())/profile/\(idUser)")
    guard let serviceURL = URL(string: Url) else { return }
//        var request = URLRequest(url: serviceURL)
    var request = URLRequest(url: serviceURL,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    let tksession = UserDefaults.standard.string(forKey: "idToken")
    request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
//    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared.dataTask(with: request){ (data, response, error) in
        //print("->  respuesta Status Code: ", response as Any)
        //print("->  error: ", error as Any)

        if let response = response {
            print("response SN: \(response)")
        }
        if let data = data {
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(ProfileMatchData.self, from: data)
                UserDefaults.standard.set(responseModel.result?.id, forKey: "SNId")
            } catch {
                print("Error")
                APIType.shared.refreshToken()
            }
        }
    }
    session.resume()
    
}
