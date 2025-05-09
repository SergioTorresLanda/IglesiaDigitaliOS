//
//  IntentionsProtocols.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 27/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol IntentionsWireframeProtocol: class {

}
//MARK: Presenter -
protocol IntentionsPresenterProtocol: class {
    func requestlocations()
    func getResponse(errores: ServerErrors, data: PriestChurches?)
    func responseSearchBar(errores: ServerErrors, result: [Assigned])
    func searchBarIntentionsChurch(name: String)
}

//MARK: Interactor -
protocol IntentionsInteractorProtocol: class {

    var presenter: IntentionsPresenterProtocol?  { get set }
    
    func requestlocations()
    func requestSearchBar(name: String)
}

//MARK: View -
protocol IntentionsViewProtocol: class {

  var presenter: IntentionsPresenterProtocol?  { get set }
    
    func loadOptions(data: PriestChurches)
    func showSearchBarResponse(result: [Assigned])
}
