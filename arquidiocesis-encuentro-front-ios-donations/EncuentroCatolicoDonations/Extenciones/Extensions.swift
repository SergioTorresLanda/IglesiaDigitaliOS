//
//  Extensions.swift
//  EncuentroCatolicoDonations
//
//Sergio Torres Landa

import Foundation
import UIKit

extension UIView {
    
    func ShadowNavBar() {
        clipsToBounds = true
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func ShadowCard() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
}

extension UITableView {
    func shadowTable() {
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Character {
    func unicodeScalarCodePoint() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}

extension UIImageView {
    func DownloadImage(_ uri : String) {
        guard let url = URL(string: uri) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {responseData,response,error in
        
            if error == nil {
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        //print("Fin del hilo imagen muestra ECDonations Ext ")
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print("error")
            }
        }
        task.resume()
    }
}

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
