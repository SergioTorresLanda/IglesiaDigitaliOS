//
//  HomeServicePresenter.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

class HomeServicePresenter: HomeServicePresenterProtocol, HomeServiceInteractorOutputProtocol {
    weak var view: HomeServiceViewProtocol?
    var interactor: HomeServiceInteractorInputProtocol?
    var wireFrame: HomeServiceWireFrameProtocol?

    init() {}
}
