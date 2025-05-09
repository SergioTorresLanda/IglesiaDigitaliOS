//
//  NotificationsProtocols.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Diego Martinez on 01/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation
import RealmSwift

//MARK: Wireframe -
protocol NotificationsWireframeProtocol: class {
    
    //MARK: - ShowPostDetail
    func showPostDetail(navController: UINavigationController?, post: PublicationRealm)
}

//MARK: Presenter -
protocol NotificationsPresenterProtocol: class {
    
    //MARK: - Firebase
    func getNotifications(userId: Int)
    func didFinishGettingNotifications(data: [NotificationDocument])
    func writeIsViewed(documentId: String)
    
    
    //MARK: - ShowPostDetail
    func showPostDetail(navController: UINavigationController?, post: PublicationRealm)
}

//MARK: Interactor -
protocol NotificationsInteractorProtocol: class {
    
    var presenter: NotificationsPresenterProtocol?  { get set }
    
    //MARK: - Firebase
    func getNotifications(userId: Int)
    func writeIsViewed(documentId: String)
}

//MARK: View -
protocol NotificationsViewProtocol: class {
    
    var presenter: NotificationsPresenterProtocol?  { get set }
    
    //MARK: - Firebase
    func didFinishGettingNotifications(data: [NotificationDocument])
}
