//
//  EditionPromisseInteractor.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

class EditionPromisseInteractor: NSObject {
    weak var presenter: EditionPromissePresenter?
    private var host: String = "https://fiel.arquidiocesis.mx"
}

extension EditionPromisseInteractor: EditionPromisseInteractorProtocol{
    func getCatalogImageSaints() {
        let imageSaintsModel = [
            ImageSaintsModel(id: 1, imageCode: "001"),
            ImageSaintsModel(id: 2, imageCode: "002"),
            ImageSaintsModel(id: 3, imageCode: "003"),
            ImageSaintsModel(id: 4, imageCode: "004"),
            ImageSaintsModel(id: 5, imageCode: "005"),
            ImageSaintsModel(id: 6, imageCode: "006"),
        ]
        presenter?.responseImageSaints(response: imageSaintsModel)
    }
    
    func getCatalogTimePromise() {
        let timePromise = [
            TimerPromiseModel(timeToPromise: "1 Día", timeOnDays: 1),
            TimerPromiseModel(timeToPromise: "3 Dias", timeOnDays: 3),
            TimerPromiseModel(timeToPromise: "5 Dias", timeOnDays: 5),
            TimerPromiseModel(timeToPromise: "1 Semana", timeOnDays: 7),
            TimerPromiseModel(timeToPromise: "2 Semanas", timeOnDays: 14),
            TimerPromiseModel(timeToPromise: "3 Semanas", timeOnDays: 21),
            TimerPromiseModel(timeToPromise: "4 Semanas", timeOnDays: 28),
            TimerPromiseModel(timeToPromise: "1 Mes", timeOnDays: 30),
            TimerPromiseModel(timeToPromise: "3 Meses", timeOnDays: 90),
            TimerPromiseModel(timeToPromise: "6 Meses", timeOnDays: 180),
            TimerPromiseModel(timeToPromise: "9 Meses", timeOnDays: 270),
            TimerPromiseModel(timeToPromise: "1 Año", timeOnDays: 365),
            TimerPromiseModel(timeToPromise: "2 Años", timeOnDays: 730),
            TimerPromiseModel(timeToPromise: "3 Años", timeOnDays: 1095),
            TimerPromiseModel(timeToPromise: "Siempre", timeOnDays: 0)
        ]
        presenter?.responseTimePromise(response: timePromise)
    }
    
    
    func getCatalogSaints() {
        guard let endpoint: URL = URL(string: "\(host)/catalog/reason") else {
            print("Error formando url")
            // self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorHome.ErrorInterno, user: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                self.presenter?.responseSaints(
                    response:
                        [SaintsModel(id: 1, name: "La Virgen de Guadalupe"),
                         SaintsModel(id: 2, name: "A dios"),
                         SaintsModel(id: 3, name: "A todos los santos")])
                return
            }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.presenter?.responseSaints(
                    response:
                        [SaintsModel(id: 1, name: "La Virgen de Guadalupe"),
                         SaintsModel(id: 2, name: "A dios"),
                         SaintsModel(id: 3, name: "A todos los santos")])
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                print(responseJSON)
                // let object = responseJSON["data"] as? [String:Any] ?? [:]
                //                let responseGeneral:ResponseGeneral = ResponseGeneral(JSON: object)!
                
                //  let userHome: UserRespHome? = try? JSONDecoder().decode(UserRespHome.self, from: data!)
                
                //  self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorHome.Ok, user: userHome)
                
            } else {
                self.presenter?.responseSaints(
                    response:
                        [SaintsModel(id: 1, name: "La Virgen de Guadalupe"),
                         SaintsModel(id: 2, name: "A dios"),
                         SaintsModel(id: 3, name: "A todos los santos")])
                //let resp = try? JSONDecoder().decode([String:String].self, from: data!)
                
                //  self.presenter?.obtieneRespuetaUsuario(errores: ErroresServidorHome.ErrorServidor, user: nil)
            }
            
        }
        tarea.resume()
    }
    
    
}
