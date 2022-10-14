//
//  NetworkingApi.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import Foundation

private let kErrorMap: [Int: ResponseType] = [
    400: .badRequest,
    401: .unauthorized,
    403: .forbidden,
    404: .notFound,
    408: .requestTimeOut,
    409: .conflict,
    410: .gone,
    422: .unprocessable,
    426: .upgradeRequired,
    500: .internalError,
    502: .badGateway,
    503: .serviceUnavailable,
    504: .gatewayTimeOut,
    NSURLErrorCancelled: .canceled,
    NSURLErrorTimedOut: .clientTimeOut,
    NSURLErrorNotConnectedToInternet: .notConnected,
]

enum HTTPMethodSOS: String {
    case options, get, head, post, put, patch, delete, trace, connect
}

public enum ResponseType {
    case succeed
    case badRequest, unauthorized, upgradeRequired, forbidden, gone
    case canceled, unprocessable, notFound, unknownError, clientTimeOut, notConnected
    case conflict, internalError, badGateway, serviceUnavailable, requestTimeOut, gatewayTimeOut

    init(fromCode code: Int) {
        if code >= 200 && code < 300 {
            self = .succeed
            return
        }

        self = kErrorMap[code] ?? .unknownError
    }
}

protocol NetworkingService {
    @discardableResult func getLocations(withQuery query: String, completion: @escaping ([LocationSOS]) -> Void) -> URLSessionDataTask

    @discardableResult func changeStatusService(status: String, id: String, completion: @escaping () -> Void) -> URLSessionDataTask
    @discardableResult func registerService(withParameters parameters: [String: Any?], completion: @escaping (ResponseType) -> Void) -> URLSessionDataTask
    @discardableResult func statusNotification(serviceId: Int, completion: @escaping (statusNotificationSOS) -> Void) -> URLSessionDataTask
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    let baseUrl = "\(APIType.shared.User())"

    @discardableResult
    func getLocations(withQuery query: String, completion: @escaping ([LocationSOS]) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "\(baseUrl)/locations?type=SOS&latitude=19.392642&longitude=-99.08929")!)
        let task = session.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([LocationSOS].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (ResponseType) -> Void) -> URLSessionDataTask {
        let request = urlRequest(method: .post, parameters: parameters)
        
        let task = session.dataTask(with: request) { data, response, _ in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 500
            let status = ResponseType(fromCode: statusCode)
            
            DispatchQueue.main.async {
                completion(status)
            }
        }

        task.resume()
        return task
    }
    

    @discardableResult
    func changeStatusService(status: String, id: String, completion: @escaping () -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "\(baseUrl)/services/" + id)!)
        let task = session.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                
                completion()
            }
        }
        task.resume()
        return task
    }
    
    @discardableResult
    func statusNotification(serviceId: Int, completion: @escaping (statusNotificationSOS) -> Void) -> URLSessionDataTask {
        let request = URLRequest(url: URL(string: "\(baseUrl)/services/\(serviceId)?type=SOS")!)
        let task = session.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(statusNotificationSOS.self, from: data) else {
//                    completion(Void)
                    return
                }
                completion(response)
            }
        }
        task.resume()
        return task
    }
    
    private func urlRequest(method: HTTPMethodSOS, parameters: [String: Any?]? = nil) -> URLRequest
    {
        var request = URLRequest(url: URL(string: "\(baseUrl)/services")!)
        request.httpMethod = method.rawValue

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch let error {
                print(error.localizedDescription)
            }
        }

        return request
    }
}
