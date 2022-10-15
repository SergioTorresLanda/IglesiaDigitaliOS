//
//  FirstMan_Interactor.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 07/05/21.
//

import Foundation

protocol SSVIPER_PresenterToInteractorProtocol: class {
    var _presenter: SSVIPER_InteractorToPresenterProtocol? {set get}
    func closeSesion()
    func cancelAnyRequest()
    func getData()
    func getDataCatalog()
}

class SVS_ProfileInteractor: SSVIPER_PresenterToInteractorProtocol {
    var _presenter: SSVIPER_InteractorToPresenterProtocol?
    
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    public init() { }

    public func getFormations() -> Void {
        var request = URLRequest(url: URL(string: "https://api-develop.arquidiocesis.mx/formations")!,timeoutInterval: Double.infinity)
//        var request = URLRequest(url: URL(string: "\(APIType.shared.User())/formations")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore (value: 0)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            guard let data = data else {
                semaphore.signal()
                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
                return
            }
            do{
                let userResponse = try JSONDecoder().decode(FF_FormationObj_Entity.self, from: data)
                self._presenter?.setData(data: userResponse)
            }catch let error {
                print("Error: \(error.localizedDescription)")
                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    public func getFormationCatalog() -> Void{
        var request = URLRequest(url: URL(string: "https://api-develop.arquidiocesis.mx/catalog/library-themes")!,timeoutInterval: Double.infinity)
//        var request = URLRequest(url: URL(string: "\(APIType.shared.User())/catalog/library-themes")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore (value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)

            guard let data = data else {
                semaphore.signal()
                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
                return
            }
            do{
                let userResponse = try JSONDecoder().decode(FF_CatalogObj_Entity.self, from: data)
//                self._presenter?.setData(data: userResponse)
                self._presenter?.setDataCatalog(dataCatalog: userResponse)
            }catch let error {
                print("Error: \(error.localizedDescription)")
                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func getData(){
//        self.getFormationCatalog()
        self.getFormations()
    }
    
    func getDataCatalog() {
        self.getFormationCatalog()
    }
    
    func closeSesion() {
        self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
    }
    
    func cancelAnyRequest() {
        self._presenter?.errorCloseSesion(code: 0, msg: "Cancel request ")
    }
}
