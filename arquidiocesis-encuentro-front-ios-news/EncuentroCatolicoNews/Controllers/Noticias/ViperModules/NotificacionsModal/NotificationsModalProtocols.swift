//
//  NotificationsModalProtocols.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Consultor on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol NotificationsModalWireframeProtocol: class {

}

//MARK: Presenter -
protocol NotificationsModalPresenterProtocol: class {
    
}

//MARK: Interactor -
protocol NotificationsModalInteractorProtocol: class {
    
    var presenter: NotificationsModalPresenterProtocol?  { get set }
    
}

//MARK: View -
protocol NotificationsModalViewProtocol: class {
    
    var presenter: NotificationsModalPresenterProtocol?  { get set }
    
}
