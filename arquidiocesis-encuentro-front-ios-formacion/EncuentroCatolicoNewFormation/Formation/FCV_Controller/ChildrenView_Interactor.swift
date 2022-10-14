//
//  AdultView_Interactor.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit

protocol FCV_VIPER_PresenterToInteractorProtocol: class {
    var _presenter: FCV_VIPER_InteractorToPresenterProtocol? {set get}
    func getData()
}

class FCV_ProfileInteractor: FCV_VIPER_PresenterToInteractorProtocol {
    var _presenter: FCV_VIPER_InteractorToPresenterProtocol?
    
    public func getFormationsComponets() -> Void {
        var component = URLComponents(string: "https://api-develop.arquidiocesis.mx/formations")!
        component.queryItems = [
            URLQueryItem(name: "type", value: "CHILDREN")
        ]
        var request = URLRequest(url: component.url!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore (value: 0)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                semaphore.signal()
//                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
                return
            }
            do{
                let userResponse = try JSONDecoder().decode([FF_Formation_Entity].self, from: data)
                userResponse.forEach({ print("-|\($0.title)|-") })
                self._presenter?.setDataSingle(data: userResponse)
            }catch let error {
                print("Error: \(error.localizedDescription)")
//                self._presenter?.errorCloseSesion(code: 90, msg: "Hola")
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
    
    func getData(){
        getFormationsComponets()
    }
}
