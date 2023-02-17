//
//  FollowersInteractor.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//  
//

import Foundation

enum EntitiesType: String{
    case User
    case Church
    case Community
    
    var intValue: Int{
        switch self {
        case .User:
            return 1
        case .Church:
            return 2
        case .Community:
            return 3
        }
    }
}

class FollowersInteractor: FollowersInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: FollowersInteractorOutputProtocol?
    var remoteDatamanager: FollowersRemoteDataManagerInputProtocol?
    let tksession = UserDefaults.standard.string(forKey: "idToken")
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    private var snService = SocialNetworkService()
    var nextPage = ""
    var arPostGral: [Posts] = [Posts]()
    var numPosts = 0
 
    func followAndFollowUF(method: String, entityId: Int, entityType: Int) {
        var urlString = ""
        var fuf=false
        if method == "POST" {
            fuf=true
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
        print("::: FOLLOW/UF DESDE SEGUIDOS :::")
        print(urlString)
        print(bodyParams)
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        //print(tksession)
        //print(body)
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
                self.presenter?.followAndUnFollowSuccess(fuf:fuf)
                print("Success Follow and unfollow content")
                print(contentReponse)
                
            }catch{
                print("Error follow", error, error.localizedDescription)
                //self.presenter?.onFailRequestFollowUF(error: error)
            }
        }
        work.resume()
    }
    
    func getFollowers(snId:Int) {
        remoteDatamanager?.getFollowers(snId:snId)
    }
    
    func getFollowed(snId:Int) {
        remoteDatamanager?.getFollowed(snId:snId)
    }
    
    func getNewPostsF(isFromPage: Bool, isRefresh: Bool){
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let params = Timeline(userId: "\(SNId)", nextPage: "")
        self.callService(nxtPage: "", userId: "\(SNId)", params: params, isFromPage: isFromPage, isPagination: false, isRefresh: isRefresh)
    }
    
    func callService(nxtPage: String?, userId: String, params: Timeline?, isFromPage: Bool, isPagination: Bool, isRefresh: Bool){
        print(":::::::: CALL SERVICE ;;;;;;;;;;")
        let stUrl = "\(APIType.shared.SN())/users/\(SNId)/timeline"
        if isRefresh{
            nextPage=""
            self.numPosts = 0
            UserDefaults.standard.removeObject(forKey: "nextPageTL")
            self.arPostGral = []
        }
        var request = snService.getRequestRS(strUrl: stUrl, pagination: nextPage, method: .publicationsAll, params: params)
        request.timeoutInterval = 40
        snService.makeRequest(request: request) { (data, error) in
            if let error = error{
                    print("::::ERROR CALL SERVICE::: "+error.message)
                    print(stUrl)
                    print("didFinishGettingPostsWithErrors 1")
                //self.presenter?.didFinishGettingPostsWithErrors(error: error)
            }else{
                do {
                    if isPagination{
                        self.numPosts = 0
                    }
                    if !isFromPage{
                        UserDefaults.standard.removeObject(forKey: "nextPageTL")
                    }
                    let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments) as! [String: Any]
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let allData = data else { return }
                    let responseModel = try jsonDecoder.decode(RSTimeLine.self, from: allData)
                    let arr = responseModel.result?.posts
                    let dctResult = someDictionaryFromJSON["result"] as? [String: Any]
                    let dctPagination = dctResult?["pagination"] as? [String: Any]
                    //let hasMore = dctPagination?["hasMore"] as? Bool ?? false
                    let stNextPag = dctPagination?["next"] as? String ?? ""
                    self.nextPage=stNextPag
                    print("::::NEXT PAGE VALUE::: "+stNextPag)
                    UserDefaults.standard.set(nxtPage, forKey: "nextPageTL")
                    self.presenter?.didFinishGettingPostsF(isFromPage: isFromPage, posts: arr ?? [])
                }catch{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        print("::::CATCH CALL SERVICE::: ")
                        print("didFinishGettingPostsWithErrors 2")
                    })
                    //self.presenter?.didFinishGettingPostsWithErrors(error: SocialNetworkErrors.ResponseError)
                }
            }
            
        }
    }
}

extension FollowersInteractor: FollowersRemoteDataManagerOutputProtocol {
    func followAndUnFollowSuccess(fuf:Bool) {
        presenter?.followAndUnFollowSuccess(fuf:fuf)
    }
    
    func followAndUnFollowError(with error: SocialNetworkErrors) {
        presenter?.followAndUnFollowError(with: error)
    }
    
    func getFollowersResponse(with response: ResponseFollowers?, hasMore: Bool) {
        var arrFollowers: [Followers] = []
        guard let response = response else {
            presenter?.getArrFollowers(followers: arrFollowers, hasMore:hasMore)
            return
        }

        for users in response.result.Follows{
            let follower = Followers(image: users.image, name: users.name, isFollow: knowIfIFollow(status: users.relationshipStatus), userId: users.id, entityId: users.relationshipId, entityType: EntitiesType(rawValue: users.type)?.intValue ?? 1)
            arrFollowers.append(follower)
        }
        
        presenter?.getArrFollowers(followers: arrFollowers, hasMore:hasMore)
    }
    
    func getFollowedResponse(with response: ResponseFollowers?, hasMore: Bool) {
        var arrFollowers: [Followers] = []
        guard let response = response else {
            presenter?.getArrFolloweds(followeds: arrFollowers, hasMore:hasMore)
            return
        }

        for users in response.result.Follows{
            let follower = Followers(image: users.image, name: users.name, isFollow: knowIfIFollow(status: users.relationshipStatus), userId: users.id, entityId: users.relationshipId, entityType: EntitiesType(rawValue: users.type)?.intValue ?? 1)
            arrFollowers.append(follower)
        }
        
        presenter?.getArrFolloweds(followeds: arrFollowers, hasMore:hasMore)
    }
    
    func knowIfIFollow(status: Int) -> Bool{
        return status == 1 || status == 3
    }
}
