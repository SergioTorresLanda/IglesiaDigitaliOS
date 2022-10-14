//
//  APIManager.swift
//  EncuentroCatolicoUtils
//
//  Created by Jorge Cruz on 29/03/21.
//

import UIKit
import Foundation
import OSLog

public enum HTTPMethod: String{
    case POST = "POST"
    case GET = "GET"
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like viewDidLoad.
    static let apiManager = OSLog(subsystem: subsystem, category: "apiManager")
}

open class APIManager: NSObject {

    public static var shareManager = APIManager()
    
    private func encode<T:Codable> (object: T) -> ([String: Any]){
        
        let objectJSON = try! JSONEncoder().encode(object)
        let jsonObject = try! JSONSerialization.jsonObject(with: objectJSON, options: [])
        let data       = jsonObject as? [String: Any] ?? [:]
        return data
    }
      
    public func decode<T:Decodable> (JSONObject: Data, entity : T.Type) -> (T){
        let objectdecoded   = try! JSONDecoder().decode(T.self, from: JSONObject)
        return objectdecoded
    }
  
    private func configurationRequest()->URLSession{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 10.0
        return URLSession(configuration: sessionConfig)
    }
    
    private func headerRequest(url:URL,method:HTTPMethod,authorization: String = "")->URLRequest{
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if authorization != ""{
            request.setValue(authorization, forHTTPHeaderField: "Authorization")
        }
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue
        return request
    }
    
    private func bodyRequest<K: Codable>(urlrequest: NSMutableURLRequest, body: K)->URLRequest{
        let json = self.encode(object: body)
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//        let data = try! JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//        let jsonData = json!.data(using: String.Encoding.utf8.rawValue);
        urlrequest.httpBody = data
        return urlrequest as URLRequest
    }
    
    private func paramsRequest(url:String, params: [URLQueryItem])->URL{
        var urlFormat = URLComponents(string: url)
        urlFormat?.queryItems = params
        return (urlFormat?.url)!
    }
    
    public func getServices(
        method  : HTTPMethod = .GET,
        route   : String,
        params: [URLQueryItem] = [URLQueryItem](),
        success: @escaping (_ response: Decodable, _ responseCode: Int,_  responseMessage: String) -> Void,
        failure: @escaping (_ response: Decodable?, _ responseCode: Int,_  responseMessage: String) -> Void)
    {
        let session = configurationRequest()
        //session.invalidateAndCancel()
        let url = paramsRequest(url: route, params: params)
        os_log("URL: %{uri}@", log: OSLog.apiManager, type: OSLogType.debug, url.absoluteURL as CVarArg)
        let request = headerRequest(url: url, method: method)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                failure(nil,500, "Error de servidor")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard data?.count != 0 else{
                    failure(nil,500, "Error de servidor")
                    return
                }
                success(data,200,"")
            }else if (response as! HTTPURLResponse).statusCode != 500{
                guard data?.count != 0 else{
                    failure(nil,500, "Error de servidor")
                    return
                }
                success(data,(response as! HTTPURLResponse).statusCode,"")
            }else{
                failure(nil,500, "Error de servidor")
            }
            
        }
        task.resume()
        
    }
    
    public func postServices<K : Codable>(
        method  : HTTPMethod = .POST,
        route   : String,
        body  : K,
        success: @escaping (_ response: Decodable, _ responseCode: Int,_  responseMessage: String) -> Void,
        failure: @escaping (_ response: Decodable?, _ responseCode: Int,_  responseMessage: String) -> Void)
    {

        let session = configurationRequest()
        guard let url = URL(string: route) else{
            return 
        }
        os_log("URL: %{uri}@", log: OSLog.apiManager, type: OSLogType.debug, url.absoluteURL as CVarArg)
        var request = headerRequest(url: url, method: method)
        request = bodyRequest(urlrequest: request as! NSMutableURLRequest, body: body)
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                failure(nil,500, "Error de servidor")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard data?.count != 0 else{
                    failure(nil,500, "Error de servidor")
                    return
                }
                success(data,200,"")
            }else if (response as! HTTPURLResponse).statusCode != 500{
                guard data?.count != 0 else{
                    failure(nil,500, "Error de servidor")
                    return
                }
                success(data,(response as! HTTPURLResponse).statusCode,"")
            }else{
                failure(nil,500, "Error de servidor")
            }
            
        }
        task.resume()
    }
    
}
