//
//  SecurityInfoHandler.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 07/12/22.
//

import Foundation

final class SecurityInfoHandler {
    static func getInfoBy(provider: SecurityProvider) -> Info? {
        guard let providerInfo: SecurityInfo = self.get(provider: provider) else {
                  return nil
              }
        
        return Info(data: Data(providerInfo.certificate.utf8), extra: Data(repeating: 0, count: 16))
    }
    
    private static func get(provider: SecurityProvider) -> SecurityInfo? {
        guard let file: FileInfo = self.getFileInfo() else { return nil }
        
        return file.data.filter { $0.provider == provider.rawValue }.first
    }
    
    private static func getFileInfo() -> FileInfo? {
        guard let info: Data = SecurityManager.configure() else { return nil }
        
        return try? JSONDecoder().decode(FileInfo.self, from: info)
    }
}
