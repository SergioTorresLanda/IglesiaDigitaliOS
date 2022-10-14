

import Foundation
public protocol ResponseDispatcher {
    associatedtype ResponseType: Codable
    var data: RequestType { get }
    var parameters: [String: Any]? { get }
    var urlOptional: String? { get }
}

public extension ResponseDispatcher {
    func execute (
        
        disparador: ProtocolNewtworkManager = ConnectionManager.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (Error, String) -> Void
    ) {
       
        disparador.dispatch(
            request: self.data,
            onSuccess: { (responseData: Data) in
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    do {
                        let jsonData: Data = responseData
                        let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
                        
                        if let message = jsonDict?["error"]  {
                            onError(ErrorManager.errorServicio,"Error en webs service")
                        } else {
                            DispatchQueue.main.async {
                            onSuccess(result)
                            
                            }
                        }
                        
                    }catch{
                        onError(ErrorManager.errorServicio, "Error" )
                    }
                    
                       
                    
                } catch let error {
                    DispatchQueue.main.async {
                        print("Error en Response Dispatcher parsing la data...\(error)")
                        onError(ErrorManager.errorServicio, "Error al parsear datos")
                       // onError(error, "TITLE_ERROR_SERVICIO".localiz())
                        return
                    }
                }
        },
            onError: { (error: Error, message: String) in
                DispatchQueue.main.async {
                   
                   //   onError(error, "TITLE_NO_INTERNET".localiz())
                  
                }
        }
        )
    }
}
