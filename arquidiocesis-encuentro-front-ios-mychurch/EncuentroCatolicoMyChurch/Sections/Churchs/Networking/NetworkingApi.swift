//
//  NetworkingApi.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

protocol NetworkingService {
    @discardableResult func searchChurchs(withQuery query: String, completion: @escaping ([Church]) -> Void) -> URLSessionDataTask
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared

    @discardableResult
    func searchChurchs(withQuery query: String, completion: @escaping ([Church]) -> Void) -> URLSessionDataTask {
        let queryEncoding = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        let request = URLRequest(url: URL(string: "https://rc1hfd6cjd.execute-api.us-east-1.amazonaws.com/dev/v3/locations?name=\(queryEncoding ?? "")")!)
        
        let task = session.dataTask(with: request) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([Church].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
        return task
    }
}
