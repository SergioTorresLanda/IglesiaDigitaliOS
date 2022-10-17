//
//  FaithfulInteractor.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import Foundation

final class FaithfulInteractor: FaithfulInteractorInputsType {
    weak var presenter: FaithfulInteractorOutputsType?
    
    // Dependencies
    private let dataManager: LocationsRemoteDataManager
    
    init(dataManager: LocationsRemoteDataManager = LocationsRemoteDataManager()) {
        self.dataManager = dataManager
    }
    
    func getLocations() {
        dataManager.getLocations(for: "", completion: { [weak self] Locations in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.didRetrieveLocations(Locations)
        })
    }
    
    func registerServices(parameters: [String: Any?]) {
        let endpoint: URL = URL(string: "\(APIType.shared.User())/services")!
        var request = URLRequest(url: endpoint)
        request.timeoutInterval = 2
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  data: ", data)
            print("-->>  response: ", response)
            print("-->>  error: ", error)
            if error != nil {
                print("Error")
                return
            }
            
            guard let allData = data else { return }
            if (response as! HTTPURLResponse).statusCode == 200 || (response as! HTTPURLResponse).statusCode == 201{
                DispatchQueue.main.async {
                    do {
                        let options = try JSONDecoder().decode(ServiceID.self, from: allData)
                        self.presenter?.didRegisterServicesSuccess(status: true, id: options.service_id ?? 0)
                    } catch {
                        self.presenter?.didRegisterServicesSuccess(status: false, id: 0)
                    }
                }
            } else {
                APIType.shared.refreshToken()
                DispatchQueue.main.async{ [self] in
                    self.presenter?.didRegisterServicesSuccess(status: false, id: 0)
                }
            }
        }
        tarea.resume()
    }
}

struct ServiceID: Codable {
    let service_id: Int?
    
    enum CodingKeys: String, CodingKey {
        case service_id = "service_id"
    }
}
