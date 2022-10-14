//
//  WSManager.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import Alamofire


extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}

class WSManager {
    
    //MARK: Json decoder
    private let jsonDecoder = JSONDecoder()
    
    @discardableResult
    public func makePost<RESPONSE: Codable> (url: String, encoding: JSONEncoding = JSONEncoding.default, headers: HTTPHeaders? = ["Content-Type":"application/json"], dataToSend: String, expectedResponseType: RESPONSE.Type, completion: @escaping (Result<(RESPONSE?, HTTPURLResponse?), NetworkError>) -> ()) -> Request? {
        return AF.request(url, method: .post, parameters: [:], encoding: dataToSend, headers: headers, interceptor: nil, requestModifier: nil).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(.noResponse))
                    return
                }
                
                if (response.response?.statusCode ?? 404) == 200 {
                    do {
                        let genericHandler = try self.jsonDecoder.decode(ResponseBase<RESPONSE>.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success((genericHandler.resultado, response.response)))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.badResponse(response.data)))
                        }
                        return
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.unexpectedStatusCode(response.response?.statusCode, response.data)))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(.unexpectedStatusCode(error.responseCode, response.data)))
                }
                return
            }
        }
    }
    
}
