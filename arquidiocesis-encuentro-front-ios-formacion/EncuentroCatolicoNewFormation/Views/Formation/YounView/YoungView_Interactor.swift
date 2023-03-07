//
//  YoungView_Interactor.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit
import EncuentroCatolicoUtils

protocol FYV_VIPER_PresenterToInteractorProtocol: AnyObject {
    var _presenter: FYV_VIPER_InteractorToPresenterProtocol? {set get}
    func getData(strTypeCatalog: String)
    func getFormationCatalog()
}

class FYV_ProfileInteractor: FYV_VIPER_PresenterToInteractorProtocol {
    var _presenter: FYV_VIPER_InteractorToPresenterProtocol?
    let tokenDefault="eyJraWQiOiJ0M1FVeVRYNHdOQWhkdmRMQlZPWktwXC9ySmlBclRkTmlmN0FHc3FSM1BLMD0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI2MmM4NjI3OC02ZWE3LTRiNWUtOWJkMy02NDAwOTI3Y2MyZjgiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInByb2ZpbGUiOiJERVZPVEVEIiwiaXNzIjoiaHR0cHM6XC9cL2NvZ25pdG8taWRwLnVzLWVhc3QtMS5hbWF6b25hd3MuY29tXC91cy1lYXN0LTFfOXNib044VXhuIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjpmYWxzZSwiY29nbml0bzp1c2VybmFtZSI6IjU2ZmJmYzRkLTA1ZDItNDNmYS04YjhjLTA5YzhmZmRkOTg0MiIsIm1pZGRsZV9uYW1lIjoiTGFuZGEiLCJvcmlnaW5fanRpIjoiYzdlNDkxMTItNGFiMC00ZjA2LTg4MjQtYjViOGRlNGE0NTQxIiwiYXVkIjoiNTgxb3Robm5oaXZuNnU0cThwaGVtb3Rvc2UiLCJldmVudF9pZCI6IjIyMzg2ODkyLTdkYzItNGUyNC05MWMyLTgxMjI0NTU4MWYxYyIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNjc3MTAzMTMyLCJuYW1lIjoiU2VyZ2lvIiwicGhvbmVfbnVtYmVyIjoiKzUyOTU0NTQwNzc0NiIsImV4cCI6MTY3NzE4OTUzMiwiY3VzdG9tOnJvbGUiOiJGaWVsIiwiaWF0IjoxNjc3MTAzMTMyLCJmYW1pbHlfbmFtZSI6IlRvcnJlcyIsImp0aSI6Ijk3ZmFlNDRmLTA2MmQtNGE5Yy1iMWVmLTE0NTRhNjc1Y2E0ZCIsImVtYWlsIjoic2VyZ2lvLnRvcnJlc2xhbmRhQGdtYWlsLmNvbSJ9.QqQWg9sPCAFCfPPLleNvrLn95Mjd8cVQskLTQQypJ1BMUU0LtZ6u_dqGpTLMKU3R1gZ6i7nyT_QcKwBkh5AmAAzNHKtRmLZKRHtMM1hzTbkA0vqTzf5zQR4PAHgkNnW2TD4uXDG-R4cePpDN2wFpG4Z45_Vj4qJaaMI_ryV__hTtQbCPn2quE8Gc0VJiAGM2O_rwAX9eIp5rZcj-2-GsRNC5APzY3Q7VEYdECq7yaUkd3WbRSrtUVxpTImJEC9W1eIN8BW2DgBGaoa8-o9PIocddfbozFILCM2jxcwPyCuJET_7XtZ_9FgKgdpJNXnoFoI6vDXSHVCcPSxezFm24sQ"
    
    public func getFormationsComponets(strTypeCatalog: String) -> Void {
        guard var component = URLComponents(string: "\(APIType.shared.User())/formations") else {
            self._presenter?.onError(msg: "Ocurrió un error inesperado")
            print("Virtual Lib ERROR:: 5")
            return
        }

        component.queryItems = [
            URLQueryItem(name: "type", value: strTypeCatalog)
        ]
        
        var request = URLRequest(url: component.url!,timeoutInterval: Double.timeout)
        request.httpMethod = "GET"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        print("TOKEN sessION")
        //print(tksession)
        request.setValue("Bearer \( tksession ?? tokenDefault)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Virtual Lib ERROR:: 4")
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
              return
            }
            do{
                let responseData = String(data: data, encoding: String.Encoding.utf8)
                print("DATA LIBRary:::;")
                print(responseData!)
                print("IG: data \(data)")
                let userResponse = try JSONDecoder().decode([FF_Formation_Entity].self, from: data)
                userResponse.forEach({ print("-|\($0.title)|-") })
                print("IG: userResponse \(userResponse)")
                self._presenter?.setDataSingle(data: userResponse)
            } catch {
                print("Virtual Lib ERROR:: 3")
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
            }
        }.resume()
    }
    
    public func getFormationCatalog() -> Void {
        var request = URLRequest(url: URL(string: "\(APITypeUtils.shared.getBasePath())/arquidiocesis/encuentro/v1/catalog/library-themes")!,timeoutInterval: .timeout)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {
                print("Virtual Lib ERROR:: 2")
                return
            }
            
            guard let data = data,
                  let userResponse = try? JSONDecoder().decode(FF_CatalogObj_Entity.self, from: data) else {
                print("Virtual Lib ERROR:: 1")
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
                return
            }
            
            print("IG: catalog \(userResponse.data)")
            self._presenter?.setDataCatalog(data: userResponse)
        }.resume()
    }
    
    func getData(strTypeCatalog: String){
        
        getFormationsComponets(strTypeCatalog: strTypeCatalog)
    }
}
