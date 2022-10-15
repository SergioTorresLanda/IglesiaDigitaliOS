//
//  FollowersRemoteDataManager.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//  
//

import Foundation

class FollowersRemoteDataManager:FollowersRemoteDataManagerInputProtocol {
    var remoteRequestHandler: FollowersRemoteDataManagerOutputProtocol?
    var snService: SocialNetworkService = SocialNetworkService()
    let strURLFollow = "\(APIType.shared.SN())/entity/follow"
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    
    func followProfile(follower: Followers) {
        let request = snService.postRequestFollowers(strUrl: strURLFollow, param: follower)
        snService.newmakeRequest(request: request) { [weak self] data, error in
            if let error = error {
                self?.remoteRequestHandler?.followAndUnFollowError(with: error)
            }
            guard let data = data else{
                self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                guard let message = json?["message"] as? String, message == "Operacion success" else { return }
                self?.remoteRequestHandler?.followAndUnFollowSuccess()
            }catch{
                self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
            }
        }
    }
    
    func unfollowProfile(follower: Followers) {
        let urlString = "\(APIType.shared.SN())/entity/\(follower.userId)/unfollow?userId=\(SNId)&entityType=\(follower.entityType)"
        guard let apiUrl = URL(string: urlString) else { return }
        var request = URLRequest(url: apiUrl)
        
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            do{
                guard let responseData = data else { return }
                let contentReponse = try JSONDecoder().decode(FollowResponse.self, from: responseData)
                self.remoteRequestHandler?.followAndUnFollowSuccess()
                print(contentReponse)
                
            }catch{
                print("Error follow", error, error.localizedDescription)
                self.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
            }
        }
        
        work.resume()
        
    }
    
    func getFollowers() {
        let url = "\(APIType.shared.SN())/entity/\(UserDefaults.standard.integer(forKey: "SNId"))/follows?type=2"
        let request = snService.getRequestFollowers(strURL: url)
        snService.newmakeRequest(request: request) { [weak self] data, error in
            if let error = error {
                self?.remoteRequestHandler?.followAndUnFollowError(with: error)
            }
            guard let data = data else{
                self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                return
            }
            let response = self?.decode(with: data)
            self?.remoteRequestHandler?.getFollowersResponse(with: response)
        }
    }
    
    func getFollowed() {
        let url = "\(APIType.shared.SN())/entity/\(UserDefaults.standard.integer(forKey: "SNId"))/follows?type=1"
        let request = snService.getRequestFollowers(strURL: url)
        snService.newmakeRequest(request: request) { [weak self] data, error in
            if let error = error {
                self?.remoteRequestHandler?.followAndUnFollowError(with: error)
            }
            
            guard let data = data else{
                self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                return
            }
            let response = self?.decode(with: data)
            self?.remoteRequestHandler?.getFollowedResponse(with: response)
        }
    }
    
    private func decode(with data: Data) -> ResponseFollowers?{
        return try? JSONDecoder().decode(ResponseFollowers.self, from: data)
    }
}

struct ResponseFollowers: Decodable{
    var result: FollowsResponse
}

struct FollowsResponse: Decodable{
    var Follows: [Users]
}

struct Users: Decodable{
    var id: Int
    var name: String
    var image: String
    var type: String
    var relationshipId: Int
    var relationshipStatus: Int
}
