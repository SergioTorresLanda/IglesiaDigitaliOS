//
//  BaseRouter.swift
//  Encuentro
//
//  Created by Edgar Hernandez on 4/2/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var body: Any? { get }
    var headers:HTTPHeaders? { get }
}

extension BaseRouter {
    
    func asURLRequest() throws -> URLRequest {
        
        let completeUrl: String
        if let parameters = parameters {
            completeUrl = "\(path)?\(parameters.stringFromHttpParameters())"
        } else {
            completeUrl = path
        }
        
        ///Query param para identificar de manera única cada petición
        //        var paramsWithCid = parameters ?? [:]
        //        paramsWithCid["cid"] = UUID().uuidString.lowercased()
        
        let url: URL = try completeUrl.asURL()
        var urlRequest = URLRequest(url: url)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        
        urlRequest.timeoutInterval = 60
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        
        headers?.forEach({ httpHeader in
            urlRequest.setValue(httpHeader.value, forHTTPHeaderField: httpHeader.name)
        })
        
        if let body = body {
            
            let json: Data
            do {
                if body is [String: Any] || body is [[String: Any]] {
                    json = try JSONSerialization.data(withJSONObject: body, options: [])
                } else if let codable = body as? Encodable,
                    let data = codable.toJSONData() {
                    json = data
                } else if let data = body as? Data {
                    json = data
                } else {
                    throw ErrorEncuentro.general(message: "No se puede obtener URL", code: 0)
                }
                
                urlRequest.httpBody = json
                
            } catch {
                throw Alamofire.AFError.parameterEncodingFailed(reason: Alamofire.AFError.ParameterEncodingFailureReason.jsonEncodingFailed(error: error))
            }
            
        }
        
        return urlRequest
        
    }
    
    
}

private extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

private extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            
            if key as! String == "key" || key as! String == "Key"{
                return "\(key)=\(value)"
            }
            
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
    
}

private extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
}
