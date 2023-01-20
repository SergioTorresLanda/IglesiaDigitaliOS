//
//  SocialSearchInteractor.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation
import UIKit

class SearchSocialInteractor: SocialSearchInteractorProtocol {
    weak var presenter: SocialSearchPresenterProtocol?
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    let tksession = UserDefaults.standard.string(forKey: "idToken")
    
    func getSearch(searchText: String) {
        //let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let originalString = "\(APIType.shared.SN())/searcher?q=\(searchText)&userId=\(SNId)"
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let apiURL = URL(string: urlString ?? "") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            do {
                if (response as! HTTPURLResponse).statusCode == 401 {
                    print("Here token code")
                }else{
                    guard let apiData = data else { return }
                    let contentResponse = try JSONDecoder().decode(SerachResponse.self, from: apiData)
                    self.presenter?.onSuccessRequestSearch(data: contentResponse, reponse: response as! HTTPURLResponse)
                }
                
                
            }catch{
                print("Download serach error", error, error.localizedDescription)
                self.presenter?.onFailRequestSearch(error: error)
            }
        }
        
        work.resume()
        
    }
    
    func followAndFollowUF(method: String, entityId: Int, entityType: Int) {
        var urlString = ""
        if method == "POST" {
            urlString = "\(APIType.shared.SN())/entity/follow"
        }else{
            urlString = "\(APIType.shared.SN())/entity/\(entityId)/unfollow?userId=\(SNId)&entityType=\(entityType)"
        }
        guard let apiUrl = URL(string: urlString) else { return }
        var request = URLRequest(url: apiUrl)
        
        let bodyParams: [String:Int] = [
            
            "userId" : SNId,
            "entityId" : entityId,
            "entityType" : entityType
            
        ]
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = method
        if method == "POST" {
            request.httpBody = body
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            do{
                guard let responseData = data else { return }
                let contentReponse = try JSONDecoder().decode(FollowResponse.self, from: responseData)
                self.presenter?.onSuccessRequestFollowUF(data: contentReponse, response: (response as! HTTPURLResponse))
                print("Fer conten", contentReponse)
                print(contentReponse)
                
            }catch{
                print("Error follow", error, error.localizedDescription)
                self.presenter?.onFailRequestFollowUF(error: error)
            }
        }
        
        work.resume()
        
    }
    
}
