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
    let tksession = UserDefaults.standard.string(forKey: "idToken")
    var arrFollowersG: [Followers] = []
    
    func followProfile(follower: Followers) {
        let foll2:Followers2=Followers2(userId: follower.userId, entityId: follower.entityId, entityType: follower.entityType)
        let p: [String : Any] = [
            "userId" :  SNId,
            "entityId" : foll2.entityId,
            "entityType" : foll2.entityType
        ]
        let request = snService.postRequestFollowers(strUrl: strURLFollow, param: p)
        print("VEREMOS QUE ES ESTA PARTE FOLLOW")
        print(strURLFollow) //url normal
      
        snService.newmakeRequest(request: request) { [weak self] data, error in
            if let error = error {
                print("ERROR::1::")
                print(error.message)
                self?.remoteRequestHandler?.followAndUnFollowError(with: error)
            }
            guard let data = data else{
                print("ERROR::2::")
                //self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                guard let message = json?["message"] as? String, message == "Operacion success" else { return }
                print("SUCCES FOLLOW")
                //self?.remoteRequestHandler?.followAndUnFollowSuccess()
            }catch{
                print("ERROR::3::")
                self?.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
            }
        }
    }
    ///entity/1242/unfollow?userId=11684&entityType=2
    func unfollowProfile(follower: Followers) {
        let urlString = "\(APIType.shared.SN())/entity/\(follower.userId)/unfollow?userId=\(SNId)&entityType=\(follower.entityType)"
        guard let apiUrl = URL(string: urlString) else { return }
        var request = URLRequest(url: apiUrl)
        print("VEREMOS QUE ES ESTA PARTE unfollow")
        print(urlString)
        print(request)
        print(follower)
        
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            do{
                guard let responseData = data else { return }
                let contentReponse = try JSONDecoder().decode(FollowResponse.self, from: responseData)
                //self.remoteRequestHandler?.followAndUnFollowSuccess()
                print("Dejo de seguir:::::")
                print(contentReponse)
                
            }catch{
                print("Error follow", error, error.localizedDescription)
                self.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
            }
        }
        
        work.resume()
        
    }
    
    var nxtPageFollowers=""
    func getFollowers(snId:Int) {
        let url = "\(APIType.shared.SN())/entity/\(snId)/follows?type=2"
        let request = snService.getRequestFollowers(strURL: url, pagination: nxtPageFollowers)
        snService.newmakeRequest(request: request) { (data, error) in
            if let error = error {
                self.remoteRequestHandler?.followAndUnFollowError(with: error)
            }else{
                do{
                    guard let data = data else{
                        self.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                        return
                    }
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    print(":: LA DATA RS ES:::")
                    let sJSON = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as! [String: Any]
                    let dctResult = sJSON["result"] as? [String: Any]
                    let dctPag = dctResult?["Pagination"] as? [String: Any]
                    let hasMore = dctPag?["hasMore"] as? Bool
                    //let stNextPag = dctPag?["next"] as? String
                    self.nxtPageFollowers = dctPag?["next"] as? String ?? ""
                    let response = self.decode(with: data)
                    self.remoteRequestHandler?.getFollowersResponse(with: response, hasMore: hasMore ?? false)
                    print("OBTENER LOS FOLLOWERS QUE TIENE EL USUARIO")
                    //print(url)
                    //print(response)
                }catch{
                    print("Catch 2")
                }
            }
           
        }
    }
    
    var nxtPageFollowed=""
    func getFollowed(snId:Int) {
        let url = "\(APIType.shared.SN())/entity/\(snId)/follows?type=1"
        let request = snService.getRequestFollowers(strURL: url, pagination: nxtPageFollowed)
        snService.newmakeRequest(request: request) { (data, error) in
        //snService.newmakeRequest(request: request) { [weak self] data, error in
            if let error = error {
                self.remoteRequestHandler?.followAndUnFollowError(with: error)
            }else{
                do{
                    guard let data = data else{
                        self.remoteRequestHandler?.followAndUnFollowError(with: SocialNetworkErrors.ResponseError)
                        return
                    }
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    print(":: LA DATA ED ES:::")
                    let sJSON = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as! [String: Any]
                    let dctResult = sJSON["result"] as? [String: Any]
                    let dctPag = dctResult?["Pagination"] as? [String: Any]
                    let hasMore = dctPag?["hasMore"] as? Bool
                    //let stNextPag = dctPag?["next"] as? String
                    self.nxtPageFollowed = dctPag?["next"] as? String ?? ""
                    let response = self.decode(with: data)
                    //print("Se va a poner DATA seguidos::")
                    self.remoteRequestHandler?.getFollowedResponse(with: response, hasMore: hasMore ?? false)
                    //print(url)
                    print("Se va a poner DATA seguidos:: Followers")
                    //print(response)
                }catch{
                    print("Catch 1")
                    //self.remoteRequestHandler?.followAndUnFollowError(with: error)
                }
            }
        }
    }
    
    func knowIfIFollow(status: Int) -> Bool{
        return status == 1 || status == 3
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
