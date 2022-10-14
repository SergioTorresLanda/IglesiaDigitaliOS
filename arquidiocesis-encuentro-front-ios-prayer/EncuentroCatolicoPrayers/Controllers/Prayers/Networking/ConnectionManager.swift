


import Foundation
public protocol ProtocolNewtworkManager {
    func dispatch(request: RequestType, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error, String) -> Void)
}



public struct ConnectionManager: ProtocolNewtworkManager {
    public static let instance = ConnectionManager()
    private  let sem = DispatchSemaphore(value: 0)
    private let time = DispatchTime.now() + 1.00
    private var finalData: Data?
    private init() {}
    
    public func dispatch(request: RequestType, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error, String) -> Void) {
        
        if !InternetConnection.isConnectedToNetwork() {
           // onError(ErrorManager.noInternet, "TITLE_NO_INTERNET".localiz())
        } else {
        let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 50.0
        configuration.timeoutIntervalForResource = 50.0
            
            print(request.url!)
        let session = URLSession(configuration: configuration)
       
            guard let url = URL(string: request.url!) else {
            onError(ErrorManager.errorInvalidUrl, "url incorrecta")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if request.params != nil {
            guard let params = request.params else {
                onError(ErrorManager.errorNoParameters, "no hay parametros")
                return
            }
            
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                onError(ErrorManager.errorSereliziation, "json no serializado")
                return
            }
            urlRequest.httpBody = httpBody
        }
        
        if let headers = request.headers { urlRequest.allHTTPHeaderFields = headers}
        
        print(urlRequest)
            print("Request parametros\(String(describing: request.params))")
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
             
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                   // onError(ErrorManager.errorInvalidUrl, "TITLE_ERROR_SERVICIO".localiz())
                    return
                }
          
            let message = String(decoding: dataResponse, as: UTF8.self)
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 400 || httpResponse.statusCode == 500{
                    print(httpResponse);
                    onError(ErrorManager.errorServicio,message)
                    return
                }
            }
  
            do {
            let jsonData: Data = dataResponse
            let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
                print(jsonDict as Any)
            }catch {

            }
          
        
            onSuccess(dataResponse)
        }
        
        task.resume()
        
        }
    }
}
