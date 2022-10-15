//
//  FirstMan_Route.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit
//import EncuentroCatolicoLogin

protocol SSVIPER_PresenterToRouter {
    func goToNextView(navigation: UINavigationController, url: String)
}



open class FirstMan_Route {

    static func getCatalog() -> [FF_Catalog_Entity]?{
        
        var rtnArr = [FF_Catalog_Entity]()
//        var request = URLRequest(url: URL(string: "https://api-develop.arquidiocesis.mx/catalog/library-themes")!,timeoutInterval: Double.infinity)
        var request = URLRequest(url: URL(string: "\(APIType.shared.User())/catalog/library-themes")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \(tksession ?? "")", forHTTPHeaderField: "Authorization")
        let semaphore = DispatchSemaphore (value: 0)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            guard let data = data else {
                semaphore.signal()
//                _presenterr?.errorCloseSesion(code: 90, msg: "Hola")
                return
            }
            do{
                let userResponse = try JSONDecoder().decode(FF_CatalogObj_Entity.self, from: data)
                let presenter : SSVIPER_InteractorToPresenterProtocol = SVS_ProfilePresenter()
                presenter.setDataCatalog(dataCatalog: userResponse)
                rtnArr = userResponse.data
                
            }catch let error {
                print("Error: \(error.localizedDescription)")
                APIType.shared.refreshToken()
//                _presenterr?.errorCloseSesion(code: 90, msg: "Hola")
                rtnArr = []
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return rtnArr
    }
    
    public static func createView(navigation: UINavigationController) -> UIViewController {
        
        let arrCatalog = getCatalog()
        
        let view = YoungView_Controller()
        view.arrCatalogo = arrCatalog ?? []
        let presenter_FYV : FYV_VIPER_ViewToPresenterProtocol & FYV_VIPER_InteractorToPresenterProtocol = FYV_ProfilePresenter()
        let interactor_FYV: FYV_VIPER_PresenterToInteractorProtocol = FYV_ProfileInteractor()
        let route: SSVIPER_PresenterToRouter = FirstMan_Route()
        view._presenter = presenter_FYV
        presenter_FYV.navigation = navigation
        presenter_FYV._view = view
        presenter_FYV._router = route
        presenter_FYV._interactor = interactor_FYV
        interactor_FYV._presenter = presenter_FYV
        
        return view
    }
    
}

extension FirstMan_Route: SSVIPER_PresenterToRouter{
    func goToNextView(navigation: UINavigationController, url: String) {
        let another = FFNView_Route.createView(url: url)
        navigation.pushViewController(another, animated: true)
    }
    
}


class CatalogCell: UICollectionViewCell{
    
    @IBOutlet weak var imgView: UIImageView!
    
    var showCaseImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.clear
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    func setData(data: FF_Catalog_Entity, strCode: String){
        if strCode == data.code {
            if let imageURL = URL(string: data.iconPressedUrl){
                if let imageData = try? Data(contentsOf: imageURL){
                    let image = UIImage(data: imageData)
                    showCaseImageView.image = image
                }
            }
        }else{
            if let imageURL = URL(string: data.iconUrl){
                if let imageData = try? Data(contentsOf: imageURL){
                    let image = UIImage(data: imageData)
                    showCaseImageView.image = image
                }
            }
        }
        
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            addViews()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        addSubview(showCaseImageView)
        
        showCaseImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        showCaseImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        showCaseImageView.heightAnchor.constraint(equalToConstant: 57).isActive = true
        showCaseImageView.widthAnchor.constraint(equalToConstant: 57).isActive = true
    }
}

