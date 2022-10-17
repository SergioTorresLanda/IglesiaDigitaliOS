//
//  RequestManager.swift
//  register_Framework
//
//  Created by Miguel Eduardo  Valdez Tellez  on 09/02/21.
//

import Foundation
import Alamofire

class RequestManager {
    
    static let shared = RequestManager()
    
    static var manager: Session = {
        let sesion = Session()
        return sesion
    }()

    private init() {}
    
    typealias handler<T> = (_ result: Result<T, ErrorEncuentro>, _ headers: Dictionary<String, Any>?) -> Void
    
    @discardableResult func perform<T>(route: URLRequestConvertible, decoder: Any = JSONDecoder(), completion: @escaping handler<T>) -> DataRequest where T: Codable {
        
        return RequestManager.manager.request(route).response(completionHandler: {
            (response) in
            #if PROD
            debugPrint("", response)
            #endif
            //print("->>  decoder: ", decoder)
            //print("->>  response: ", response)
           
                if let defaultError = ErrorEncuentro(response: response) {
                    completion(Result.failure(defaultError),
                               response.response?.allHeaderFields as? Dictionary<String, Any>)
                } else {
                    
                    self.completion(response: response,
                                    decoder: decoder,
                                    completion: completion)
                }

        })
        
    }
    
    
    private func completion<T>(response: AFDataResponse<Data?>, decoder: Any, completion: @escaping handler<T>) where T: Codable {
        //print("->>  decoder: ", decoder)
        //print("->>  response: ", response)
        do{
            if let defaultError = ErrorEncuentro(response: response) {
                completion(Result.failure(defaultError), nil)
            } else if let decoder = decoder as? JSONDecoder,
                let data = response.data {
                let statusCode = response.response?.statusCode
                let modelObject = try decoder.decode(T.self, from: data)
                completion(Result.success(modelObject), response.response?.allHeaderFields as? Dictionary<String, Any>)
            } else {
                completion(Result.failure(ErrorEncuentro.general(message: response.debugDescription, code: 0)), nil)
            }
            
        } catch {
            if let error = ErrorEncuentro(decodingError: error) {
                completion(Result.failure(error), nil)
            } else if let error = error as? ErrorEncuentro {
                completion(Result.failure(error), nil)
            } else {
                completion(Result.failure(ErrorEncuentro.general(message: error.localizedDescription, code: 0)), nil)
            }
        }
        
    }
    
}
