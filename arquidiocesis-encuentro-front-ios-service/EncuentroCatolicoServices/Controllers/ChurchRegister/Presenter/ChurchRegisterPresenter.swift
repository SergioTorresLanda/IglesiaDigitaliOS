//
//  ChurchRegisterPresenter.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

class ChurchRegisterPresenter: ChurchRegisterPresenterProtocol, ChurchRegisterInteractorOutputProtocol {
    weak var view: ChurchRegisterViewProtocol?
    var interactor: ChurchRegisterInteractorInputProtocol?
    var wireFrame: ChurchRegisterWireFrameProtocol?

    init() {}
}
