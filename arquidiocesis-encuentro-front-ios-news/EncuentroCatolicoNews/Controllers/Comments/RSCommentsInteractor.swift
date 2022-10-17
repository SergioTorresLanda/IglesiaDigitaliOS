//
//  RSCommentsInteractor.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 25/11/21.
//

import Foundation
import Alamofire

public struct ParamComments: Codable{
    let userId: String
    let nextPage: String
}

public struct ParamsCommentToComment: Codable{
    let postId: Int
    let commentId: Int?
    let userId: Int
    let content: String
    let asParam: Int
    let groupId: Int
    let scope: Int
    
    enum CodingKeys: String, CodingKey{
        case asParam = "as"
        case postId, commentId, userId, content, groupId, scope
    }
}

public class RSCommentsInteractor: RSCommentInteractorProtocol{
    func getRelations(SNId: Int) {
        guard let apiURL = URL(string: "\(APIType.shared.SN())/user/\(SNId)/relations") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            guard let allData = data else { return }
            
            do{
                if data != nil {
                    let contentRepsonse: RelationsData = try JSONDecoder().decode(RelationsData.self, from: allData)
                    print(contentRepsonse)
                    self.presenter?.onSuccessGetRelations(data: contentRepsonse, response: (response as! HTTPURLResponse))
                }
                
            }catch{
                print("Error to download data", error, error.localizedDescription)
                self.presenter?.onFailGetRelation(error: error)
            }
        }
        
        work.resume()
        
    }
    
    
    private var snService = SocialNetworkService()
    var presenter: RSCommentsPresenterProtocol?
    
    var arCommenstGra: [CmComments] = [CmComments]()
    var numCommenst = 0
    
    
    func getComments(isFromPage: Bool, isRefresh: Bool, post: Posts?) {
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let params = ParamComments(userId: "\(SNId)", nextPage: "")
        callCommentsService(nxtPage: "", userId: "\(SNId)", params: params, isFromsPage: isFromPage, isPagination: false, isRefresh: isRefresh, stCommentId: post?.id ?? 0)
    }
    
    func makeCommentToComment(postId: Int, commentId: Int?, userId: Int, content: String, asParam: Int, groupId: Int, scope: Int) {
        
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let params = ParamsCommentToComment(postId: postId, commentId: commentId, userId: SNId, content: content, asParam: asParam, groupId: groupId, scope: scope)
        
        addComment(params: params)
        
    }
    
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments]) {
        
    }
    
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors) {
        
    }
    
    func didFinishAddPostCommnet(isReload: Bool) {
        
    }
    
    func callCommentsService(nxtPage: String?, userId: String, params: ParamComments, isFromsPage: Bool, isPagination: Bool, isRefresh: Bool, stCommentId: Int){
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let stUrl = "\(APIType.shared.SN())/posts/\(stCommentId)/comments"
        let request = snService.getRequestRS(strUrl: stUrl, pagination: nxtPage ?? "", method: .profile, params: params)
        snService.newmakeRequest(request: request) { (data, error) in
            if let error = error {
                self.presenter?.didFinishGettingCommentsWithErrors(error: error)
            }else{
                do{
                    if isRefresh{
                        self.numCommenst = 0
                        UserDefaults.standard.removeObject(forKey: "nextPageCm")
                    }
                    if isPagination{
                        self.numCommenst = 0
                    }
                    if !isFromsPage{
                        UserDefaults.standard.removeObject(forKey: "nextPageCm")
                    }
                 
                    let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments) as! [String: Any]
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    guard let allData = data else { return }
                    let responseModel = try jsonDecoder.decode(RSComments.self, from: allData)
                    let arr = responseModel.result?.comments
                    let dctResult = someDictionaryFromJSON["result"] as? [String: Any]
                    let dctPag = dctResult?["Pagination"] as? [String: Any]
                    let hasMore = dctPag?["hasMore"] as? Bool
                    let stNextPag = dctPag?["next"] as? String
//                    if hasMore ?? false && self.numCommenst < 5{
//                        self.numCommenst += 1
//                        if let arr = arr{
//
//                            for comt in arr{
//                                self.arCommenstGra.append(comt)
//                            }
//                        }
//                        self.callCommentsService(nxtPage: stNextPag, userId: "\(SNId)", params: params, isFromsPage: isFromsPage, isPagination: false, isRefresh: false, stCommentId: stCommentId)
                   // }else{
                    self.arCommenstGra.removeAll()
                        if let arr = arr{
                            for comnt in arr{
                                self.arCommenstGra.append(comnt)
                            }
                        }
                        UserDefaults.standard.set(nxtPage, forKey: "nextPageCm")
                        self.presenter?.didFinishGettingComments(isFromPage: isFromsPage, comments: self.arCommenstGra)
                   // }
                    
                }catch{
                    self.presenter?.didFinishGettingCommentsWithErrors(error: SocialNetworkErrors.ResponseError)
                }
            }
        }
    }
    
    func addComment(params: ParamsCommentToComment){
        
        let stUrl = "\(APIType.shared.SN())/comments"
        let request = snService.postRequestRS(strUrl: stUrl, method: .commentsAll, param: params)
        snService.newmakeRequest(request: request, completion: {(data, error) in
            if let error = error {
                self.presenter?.didFinishGettingCommentsWithErrors(error: error)
            }else{
                do{
                    self.presenter?.didFinishAddPostCommnet(isReload: true)
                }catch{
                    self.presenter?.didFinishGettingCommentsWithErrors(error: SocialNetworkErrors.ResponseError)
                }
            }
        })
    }
    
    func deleteComment(idComment: Int, type: String) {
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        guard let apiURL = URL(string: "\(APIType.shared.SN())/\(type)/\(idComment)?userId=\(SNId)") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->>  Services class: RSCommentsInteractor")
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            

            do{
                guard let allData = data else { return }
                let contentResponse = try JSONDecoder().decode(ResultEditComment.self, from: allData)
                print(contentResponse)
                self.presenter?.onSuccessDeleteComment(response: (response as! HTTPURLResponse), type: type)
            }catch{
                print("Delte comment/post error", error, error.localizedDescription)
                self.presenter?.onFailGetRelation(error: error)
            }
        }
        work.resume()
    }
    
}
