//
//  CommentsInteractor.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import Foundation
import UIKit


class CommentsInteractor: CommentsInteractorProtocol {
    weak var presenter: CommentsPresneterProtocol?
    
    func getCommentsList(queryParam: String) { // 650
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations/\(queryParam)") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print("%%%", idUser)
        request.httpMethod = "GET"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            guard let allData = data else { return }
            do {
                
                if (response as! HTTPURLResponse).statusCode == 200 {
                    let contentResponse = try JSONDecoder().decode(Comments.self, from: allData)
                    self.presenter?.transportResponseCommentsList(contentData: contentResponse)
                }else{
                    APIType.shared.refreshToken()
                    self.presenter?.errorTransportCommentList(responseCode: response as! HTTPURLResponse)
                }
                
            }catch{
                print("Download comments list error", error, error.localizedDescription)
                APIType.shared.refreshToken()
            }
        }.resume()
        
    }
    
    func postCommentRating(locationID: Int, rating: Int, comment: String) { // 650
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations/\(locationID)/reviews") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        
        let parametros : [String : Any] = [
        
            "review" : comment,
            "rating" : rating
        
        ]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            
            if (response as! HTTPURLResponse).statusCode == 200 || (response as! HTTPURLResponse).statusCode == 201 {
                self.presenter?.transportSuccesPostComment()
            }else{
                APIType.shared.refreshToken()
                self.presenter?.transportErrorPostCommnet(response: response as! HTTPURLResponse)
            }
            
        }.resume()
        
    }
    
    func putCommentRating(locationID: Int, rating: Int, comment: String, reviewID: Int, type: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations/\(locationID)/reviews/\(reviewID)") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        
        let parametros : [String : Any] = [
        
            "review" : comment,
            "rating" : rating
        
        ]
        let body = try! JSONSerialization.data(withJSONObject: parametros)
        
        request.httpMethod = type
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->>  Services class: ")
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.succesUpdateComment()
            }else{
                APIType.shared.refreshToken()
                self.presenter?.failUpdateComment()
            }
            
        }.resume()
    }
    
    
}

