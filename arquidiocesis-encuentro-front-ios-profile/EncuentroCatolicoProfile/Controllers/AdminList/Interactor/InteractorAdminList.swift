//
//  InteractorAdminList.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation


class InteractorAdminList: ProtocolosAdminListInteractorInput {
    
    
    var presenter: ProtocolosAdminListInteractorOutput?
    
    func requestData(id: Int) {
        GetListData.init(id: String(id)).execute{ [weak self](result) in
            self?.presenter?.responseData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
        }
    }
    
    func getsearchBarPerson(id: Int, name: String) {
        DoPersonSearchData.init(id: String(id), name: name).execute{ [weak self](result) in
            self?.presenter?.responseData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
        }
    }
}
