//
//  OracionesDetailInteractor.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation
import UIKit
class OrcionesDetailInteractor: InteractorInputOracionesDetailProtocolo {
   
    
    var presenter: InteractorOutputOracionesDetailProtocolo?
    
    func getDetailData(id: Int) {
        CallDetail.init(id: id).execute { [weak self](result) in
            
            print(result.image_url)
          
            let modelView = DetailViewModel(id: result.id, name: result.name, icon: result.icon, type: result.type, description: result.description, image_url: result.image_url, similars: result.similars)
            self?.presenter?.isSuccessServiceInteractor(data: modelView)
           
           // self?.downloadImage(from: URL(fileURLWithPath: result.imageUrl!), result: result)
           
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorService(msg: msg)
        }

    }
    
    
   
    
  
    
    struct CallDetail: ResponseDispatcher {
        typealias ResponseType = DetailResponse
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String?
        
        var data: RequestType {
            return RequestType(path: "devotions/" + self.id!, method: .get, params: nil, url: "\(APIType.shared.User())/")
        }
        
        init(id: Int) {
            self.id = String(id)
        }
    }
}
