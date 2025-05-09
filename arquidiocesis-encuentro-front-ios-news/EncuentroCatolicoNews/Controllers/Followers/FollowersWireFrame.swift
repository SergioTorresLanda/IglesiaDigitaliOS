//
//  FollowersWireFrame.swift
//  EncuentroCatolicoNews

import Foundation
import UIKit

class FollowersWireFrame: FollowersWireFrameProtocol {

    class func createFollowersModule(user:UserBasic) -> UIViewController {
        let view = RedSocial_MiRed(nibName: "FollowersViewController", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        let presenter: FollowersPresenterProtocol & FollowersInteractorOutputProtocol = FollowersPresenter()
        let interactor: FollowersInteractorInputProtocol & FollowersRemoteDataManagerOutputProtocol = FollowersInteractor()
        let remoteDataManager: FollowersRemoteDataManagerInputProtocol = FollowersRemoteDataManager()
        let wireFrame: FollowersWireFrameProtocol = FollowersWireFrame()
        
        view.presenter = presenter
        view.profileSNid = user.id ?? 0
        view.userName = user.name ?? ""
        view.userImg = user.image ?? ""
        view.follow = user.follow ?? false
        view.type = user.type ?? ""
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
}
