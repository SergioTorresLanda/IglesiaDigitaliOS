//
//  InteractorAdminFormulario.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation

class InteractorAdminFormulario: ProtocolosAdminFormularioInteractorInput {
    var presenter: ProtocolosAdminFormularioInteractorOutput?
    
    func requestData(id: Int, locationId: Int) {
        GetModulesData.init(id: String(id), locatiosId: String(locationId)).execute{ [weak self](result) in
            self?.presenter?.responseData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
        }
    }
    
    
}
