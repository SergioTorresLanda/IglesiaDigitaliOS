//
//  String+Extension.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Aurelio Zambrano López on 14/10/22.
//

import Foundation

extension String {
    
    func getInitials() -> String? {
        
            if !self.isEmpty {
                
                var characters : [Character]    =   []
                for (index, string) in self.split(separator: " ").enumerated() {
                    
                    if index < 2 {
                        
                        characters.append(string.first ?? Character(""))
                    }
                }
                
                return String(characters)
            }
        
            return nil
    }
}
