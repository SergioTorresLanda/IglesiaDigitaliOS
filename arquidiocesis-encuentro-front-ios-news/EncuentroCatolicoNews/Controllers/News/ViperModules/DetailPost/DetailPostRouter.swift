//
//  DetailPostRouter.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import RealmSwift

public class DetailPostRouter: NSObject, DetailPostWireframeProtocol {

    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailPostViewController(nibName: "DetailPostViewController", bundle: Bundle(for: DetailPostViewController.self))
        let interactor = DetailPostInteractor()
        let router = DetailPostRouter()
        let presenter = DetailPostPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    //MARK: - CommentsDetail
//    func showComments(postId: Int, isKBFocused: Bool) {
//        let vc = CommentsRouter.createModule() as! CommentsViewController
//        vc.postId = postId
//        vc.isKBFocused = isKBFocused
//        vc.modalPresentationStyle = .custom
//        vc.transitioningDelegate = self
//        viewController?.present(vc, animated: true)
//    }
//    
    //MARK: - ShowReactions
    func showReactions(postId: Int) {
        guard let vc = ReactionsModalRouter.createModule() as? ReactionsModalViewController else {
            return
        }
        vc.postId = postId
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        viewController?.present(vc, animated: true)
    }
    
    //MARK: - ShowImages
    func showImages(navController: UINavigationController?, media: List<MediaRealm>) {
        guard let vc = ImagePresenterRouter.createModule() as? ImagePresenterViewController else { return }
        vc.media = media
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension DetailPostRouter: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
