//
//  VirtualProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created Diego Martinez on 25/02/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol VirtualWireframeProtocol: class {

}
//MARK: Presenter -
protocol VirtualPresenterProtocol: class {

}

//MARK: Interactor -
protocol VirtualInteractorProtocol: class {

  var presenter: VirtualPresenterProtocol?  { get set }
}

//MARK: View -
protocol VirtualViewProtocol: class {

  var presenter: VirtualPresenterProtocol?  { get set }
}
