//
//  SocialNetworkService.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 27/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import Alamofire

public enum Method: String {
    case publicationsMake = "publications/make"
    case publicationsAll = "publications/all"
    case reactionsAll = "reactions/all"
    case getInPublication = "reactions/getinpublication"
    case publicationsDelete = "publications/delete"
    case reactPublication = "reactions/reactpublication"
    case reactComment = "reactions/reactcomment"
    case publicationsEdit = "publications/edit"
    case commentsAll = "comments/all"
    case reactionsTop = "reactions/top"
    case makeInPublication = "comments/makeinpublication"
    case commentsDetail = "comments/detail"
    case commentsFind = "comments/find"
    case feelingsAll = "feelings/all"
    case groupsAll = "groups/all_v2"
    case makeInComment = "comments/makeincomment"
    case profile = "employees/profile"
    case publicationsWatch = "publications/watch"
}

public class SocialNetworkService {
    
    //MARK: - Properties
//    private var cryptoObject = CryptoAES()
    private var genAlert: GenericAlert?
    
    //MARK: - Methods
    public func getRequestWP<T: Codable>(method: Method, params: T?) -> URLRequest {
        let urlString: String = SocialNetworkConstant.shared.baseURL + method.rawValue
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30.0
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        let data = try! JSONEncoder().encode(params)
        request.httpBody = data

        return request
    }
    
    public func getRequestFollowers(strURL: String) -> URLRequest {
        let url = URL(string: strURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    public func getRequestRS<T: Codable>(strUrl: String, pagination: String, method: Method, params: T?) -> URLRequest{
        let nxtPag = pagination.count > 0 ? "?nextPage=\(pagination)" : ""
        let endPoint: URL = URL(string: "\(strUrl)\(nxtPag)")!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
//        let data = try? JSONEncoder().encode(param)
//        request.httpBody = data
        
        return request
    }
    
    
    public func postRequestRS<T: Codable>(strUrl: String, method: Method, param: T?) -> URLRequest{
       
        let endPoint: URL = URL(string: strUrl)!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let data = try? JSONEncoder().encode(param)
        request.httpBody = data
        
        return request
    }
    
    public func postRequestFollowers<T: Codable>(strUrl: String, param: T?) -> URLRequest{
        let endPoint: URL = URL(string: strUrl)!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        print("TOKEN SESION")
        print(tksession)
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        print(endPoint)
        print(param)
        let data = try? JSONEncoder().encode(param)
        request.httpBody = data
        
        return request
    }
    
    public func putRequestRS<T: Codable>(strUrl: String, metod: Method, param: T?) -> URLRequest{
        let endPoint: URL = URL(string: strUrl)!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        let data = try? JSONEncoder().encode(param)
        request.httpBody = data
        
        return request
    }
    
    public func deleteRequestRS(strURL: String, method: Method) -> URLRequest{
        let endPoint: URL = URL(string: strURL)!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        return request
    }
    
    public func deleteRequestRSWithParams<T: Codable>(strURL: String, param: T? = nil) -> URLRequest{
        let endPoint: URL = URL(string: strURL)!
        var request = URLRequest(url: endPoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        let data = try? JSONEncoder().encode(param)
        request.httpBody = data
        return request
    }
    
    
    public func getRequestWOP(method: Method) -> URLRequest {        
        let urlString: String = SocialNetworkConstant.shared.baseURL + method.rawValue
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.timeoutInterval = 30.0
    
        return request
    }
    
    public func makeRequest(request: URLRequest, completion: @escaping (Data?, SocialNetworkErrors?) -> Void) {
        AF.request(request).response { response in
            print(response.response)
            if response.response?.statusCode == 200, let data = response.data{
                completion(data, nil)
            } else {
                completion(nil, SocialNetworkErrors.NetworkConnection)
            }
        }
    }
    
    public func newmakeRequest(request: URLRequest, completion: @escaping (Data?, SocialNetworkErrors?) -> Void) {
        AF.request(request).response { response in
            if response.response?.statusCode == 201, let data = response.data{
                completion(data, nil)
            } else {
                completion(nil, SocialNetworkErrors.NetworkConnection)
            }
        }
    }
}
