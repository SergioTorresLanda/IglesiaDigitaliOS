//
//  MyCommunitiesMainViewWireFrame.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 12/08/21.
//

import Foundation
import UIKit

public class MyCommunitiesMainViewwWireFrame: MyCommunitiesMainViewViewWireFrameProtocol {
    
    func pushToMap(fromView vc: AnyObject, isPrincipal: Int, isPrincialBool: Bool?) {
        ChurchRegisterWireFrame.presentChurchRegisterModuleCommunity(selector: isPrincipal, from: vc, isPricipalBool: isPrincialBool ?? false)
    }
    
    func pushToCommunitiesDetail(fromView vc: AnyObject, myChourch: Bool, id: Int, isFavorite: Bool, isPrincipal: Bool, isEdit: Bool) {
        CommunitiesMainViewWireFrame.presentCommunitiesMainVieModule(fromView: vc, myChourch: myChourch, id: id, isEditProfile: isEdit, isFavorite: isFavorite, isPrincipal: isPrincipal)
    }
    public static func getController() -> UIViewController {
        
        // Generating module components
        let storyboard = UIStoryboard(name: "MyCommunitiesMainViewStoryboard", bundle: Bundle(for: Home_Comunidades.self))
        let view: MyCommunitiesMainViewProtocol = storyboard.instantiateViewController(withIdentifier: "MyCommunitiesMainViewController") as! Home_Comunidades
        let presenter: MyCommunitiesMainViewPresenterProtocol & MyCommunitiesMainViewInteractorOutputProtocol = MyCommunitiesMainViewPresenter()
        let interactor: MyCommunitiesMainViewInteractorInputProtocol = MyCommunitiesMainViewInteractor()
        let wireFrame: MyCommunitiesMainViewViewWireFrameProtocol = MyCommunitiesMainViewwWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    static func presentMyCommunitiesMainVieModule(fromView vc: AnyObject, myChourch: Bool) {
        // Generating module components
        let storyboard = UIStoryboard(name: "MyCommunitiesMainViewStoryboard", bundle: Bundle(for: Home_Comunidades.self))
        let view: MyCommunitiesMainViewProtocol = storyboard.instantiateViewController(withIdentifier: "MyCommunitiesMainViewController") as! Home_Comunidades
        let presenter: MyCommunitiesMainViewPresenterProtocol & MyCommunitiesMainViewInteractorOutputProtocol = MyCommunitiesMainViewPresenter()
        let interactor: MyCommunitiesMainViewInteractorInputProtocol = MyCommunitiesMainViewInteractor()
        let wireFrame: MyCommunitiesMainViewViewWireFrameProtocol = MyCommunitiesMainViewwWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
}
