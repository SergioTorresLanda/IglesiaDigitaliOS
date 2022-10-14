

import Foundation
public struct RequestType {
    public let path: String?
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: [String: String]?
    public let url: String?
    
    public init (
        path: String?,
        method: HTTPMethod,
        params: [String: Any?]?,
        headers: [String: String]? = ["Content-Type":"application/json", "Authorization":"Bearer \(String(UserDefaults.standard.string(forKey: "idToken") ?? ""))"],
        url: String?
    ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.url = (url ?? Endpoints.urlGlobalApp) + (path ?? "")
    }
}
