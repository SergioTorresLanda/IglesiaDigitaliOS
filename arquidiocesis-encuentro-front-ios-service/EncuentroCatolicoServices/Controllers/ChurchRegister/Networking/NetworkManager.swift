//
//  NetworkManager.swift
//  encuentro
//
//  Created by Ahmed Castro on 10/3/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import Alamofire



struct Retrier: RequestInterceptor {
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if (error.asAFError?.isSessionTaskError ?? false) && request.retryCount < 2 {
            completion(.retry)
        } else {
            completion(.doNotRetry)
        }
    }
}

class ManejadorDePeticiones {
    
    static let shared = ManejadorDePeticiones()
    
    static var manager: Session = {
        let sesion = Session(interceptor: Retrier())

        return sesion
    }()

    private init() {
        
    }
    
    typealias handler<T> = (_ result: Result<T, ErrorEncuentro>, _ headers: Dictionary<String, Any>?) -> Void
    typealias handlerVoid = (_ result: Result<Any?, ErrorEncuentro>, _ headers: Dictionary<String, Any>?) -> Void
    typealias handlerDownload = (_ result: Result<Any?, ErrorEncuentro>) -> Void
    
    @discardableResult func perform<T>(route: URLRequestConvertible, decoder: Any = JSONDecoder(), completion: @escaping handler<T>) -> DataRequest where T: Codable {
        
        return ManejadorDePeticiones.manager.request(route).response(completionHandler: {
            (respuesta) in
            
            #if !PROD
            debugPrint(respuesta)
            #endif
            
            DispatchQueue.main.async {
                if let defaultError = ErrorEncuentro(respuesta: respuesta) {
                    completion(Result.failure(defaultError), nil)
                } else {
                    self.completion(response: respuesta, decoder: decoder, completion: completion)
                }
            }
        })
        
    }
    
    @discardableResult func performVoid(route: URLRequestConvertible, completion: @escaping handlerVoid) -> DataRequest {
        
        return ManejadorDePeticiones.manager.request(route).response(completionHandler: { (respuesta) in
            #if !PROD
            debugPrint(respuesta)
            #endif
            
            DispatchQueue.main.async {
                if let defaultError = ErrorEncuentro(respuesta: respuesta) {
                    completion(Result.failure(defaultError), nil)
                } else {
                    self.completionVoid(response: respuesta, completion: completion)
                }
            }
        })
    }
    
    func donwload(url: URL, destination: URL, completion: @escaping handlerDownload) {
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = destination
            return (documentsURL, [.removePreviousFile])
        }
        
        let urlRequest = URLRequest(url: url)
        
        ManejadorDePeticiones.manager.download(urlRequest, to: destination).responseData {
            respuesta in
            
            #if !PROD
            debugPrint(respuesta)
            #endif
            
            if let defaultError = ErrorEncuentro(respuesta: respuesta) {
                completion(Swift.Result.failure(defaultError))
            } else {
                completion(Swift.Result.success(nil))
            }
        }
    }
    
    private func completion<T>(response: AFDataResponse<Data?>, decoder: Any, completion: @escaping handler<T>) where T: Codable {
        
        do{
            if let defaultError = ErrorEncuentro(respuesta: response) {
                completion(Result.failure(defaultError), nil)
            } else if let decoder = decoder as? JSONDecoder,
                let data = response.data {
                let modelObject = try decoder.decode(T.self, from: data)
                completion(Result.success(modelObject), response.response?.allHeaderFields as? Dictionary<String, Any>)
            } else {
                completion(Result.failure(ErrorEncuentro.general(mensaje: response.debugDescription, codigo: 0)), nil)
            }
            
        } catch {
            if let error = ErrorEncuentro(decodingError: error) {
                completion(Result.failure(error), nil)
            } else if let error = error as? ErrorEncuentro {
                completion(Result.failure(error), nil)
            } else {
                completion(Result.failure(ErrorEncuentro.general(mensaje: error.localizedDescription, codigo: 0)), nil)
            }
        }
        
    }
    
    private func completionVoid(response: AFDataResponse<Data?>, completion: @escaping handlerVoid) {
        if let defaultError = ErrorEncuentro(respuesta: response) {
            completion(Swift.Result.failure(defaultError), nil)
        } else {
            completion(Swift.Result.success(nil), response.response?.allHeaderFields as? Dictionary<String, Any>)
        }
    }
    
}
