//
//  FirstMan_Route.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit

open class YoungView_Route {
    public static func createView(navigation: UINavigationController) -> UIViewController {
        let view = YoungView_Controller()
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

extension YoungView_Route: SSVIPER_PresenterToRouter{
    func goToNextView(navigation: UINavigationController, url: String) {
        let another = FFNView_Route.createView(url: url)
        navigation.pushViewController(another, animated: true)
    }
    
    func showSpinner(navigation: UINavigationController) {
        navigation.showSpinner()
    }
    
    func hideSpinner(navigation: UINavigationController) {
        navigation.hideSpinner()
    }
    
    func goToErrorView(navigation: UINavigationController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            navigation.popViewController(animated: true)
        }))
        
        navigation.present(alert, animated: true)
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

