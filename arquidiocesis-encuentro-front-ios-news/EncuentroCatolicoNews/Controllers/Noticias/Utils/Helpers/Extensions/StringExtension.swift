//
//  StringExtension.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public extension String {
    var twoWords: String {
        get {
            let splitName = self.split(separator: " ")
            let namesCount = splitName.count
            return namesCount > 1 ? "\(splitName[0]) \(splitName[1])" : "\(splitName[0])"
        }
    }
    
    func getStringFrom() -> String {
        let word = NSLocalizedString(self, tableName: nil, bundle: Bundle.local, value: "", comment: "")
        return word
    }
    
    func getImage() -> UIImage {
        return UIImage(named: self, in: Bundle.local, compatibleWith: nil) ?? UIImage()
    }
    
    func getImageView() -> UIImageView {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = self.getImage()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        return backgroundImage
    }
    
    func trim(to maximumCharacters: Int) -> String {
        return "\(self[..<index(startIndex, offsetBy: maximumCharacters)])" + "..."
    }
    
    func stringForAES() -> String {
        return replacingOccurrences(of: "\\/", with: "/", options: .literal, range: nil)
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func stringToBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    func contains(_ string: String) -> Bool{
        return self.range(of: string, options: .caseInsensitive) != nil
    }
}

public extension NSMutableAttributedString {
    private var boldFont: UIFont { return UIFont(name: "Avenir-Black", size: 15)! }
    private var normalFont: UIFont { return UIFont(name: "Avenir-Book", size: 15)! }
    
    func bold(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [.font : boldFont,]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value: String) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key : Any] = [.font : normalFont,]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor(red: 1.00, green: 0.63, blue: 0.22, alpha: 1.00)
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

public extension NSAttributedString {
    func components(separatedBy separator: String) -> [NSAttributedString] {
        var result = [NSAttributedString]()
        let separatedStrings = string.components(separatedBy: separator)
        var range = NSRange(location: 0, length: 0)
        for string in separatedStrings {
            range.length = string.count
            let attributedString = attributedSubstring(from: range)
            result.append(attributedString)
            range.location += range.length + separator.count
        }
        
        return result
    }
}
