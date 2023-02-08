//
//  FollowersWireFrame.swift
//  EncuentroCatolicoNews

import Foundation
import UIKit

class FollowersWireFrame: FollowersWireFrameProtocol {

    class func createFollowersModule() -> UIViewController {
        let view = FollowersViewController(nibName: "FollowersViewController", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        let presenter: FollowersPresenterProtocol & FollowersInteractorOutputProtocol = FollowersPresenter()
        let interactor: FollowersInteractorInputProtocol & FollowersRemoteDataManagerOutputProtocol = FollowersInteractor()
        let remoteDataManager: FollowersRemoteDataManagerInputProtocol = FollowersRemoteDataManager()
        let wireFrame: FollowersWireFrameProtocol = FollowersWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
}
