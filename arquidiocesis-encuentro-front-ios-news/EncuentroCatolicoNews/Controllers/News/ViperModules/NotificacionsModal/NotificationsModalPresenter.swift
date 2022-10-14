//
//  NotificationsModalPresenter.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Consultor on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class NotificationsModalPresenter: NotificationsModalPresenterProtocol {

    weak private var view: NotificationsModalViewProtocol?
    var interactor: NotificationsModalInteractorProtocol?
    private let router: NotificationsModalWireframeProtocol

    init(interface: NotificationsModalViewProtocol, interactor: NotificationsModalInteractorProtocol?, router: NotificationsModalWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}
