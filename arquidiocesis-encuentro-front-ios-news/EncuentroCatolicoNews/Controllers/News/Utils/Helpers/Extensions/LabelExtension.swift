//
//  LabelExtension.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public extension UILabel {
    func addMoreInfo(_ appendableString: String, index: Int? = nil, image: UIImage? = nil, text: String? = nil) {
        guard let attrText = self.attributedText else { return }
        let result = NSMutableAttributedString(attributedString: attrText)
        
        if let image = image {
            let reactionText = NSMutableAttributedString().normal("  \(text ?? "se siente") ").bold("\(appendableString)")
            
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
            let attachmentString = NSAttributedString(attachment: attachment)
            reactionText.insert(attachmentString, at: 1)
            
            result.insert(reactionText, at: index!)
        } else {
            let locationText = NSMutableAttributedString().normal(" en ").bold("\(appendableString)")
            result.append(locationText)
        }
        
        self.attributedText = result
    }
    
    func addUser(name: String?) {
        guard let attrText = self.attributedText else { return }
        let result = NSMutableAttributedString(attributedString: attrText)
        guard let userName = name else { return }
    
        let nameText = NSMutableAttributedString().normal("  \(userName)")
//
//        let attachment = NSTextAttachment()
//        attachment.image = "blackTriangle".getImage()
//        attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
//        let attachmentString = NSAttributedString(attachment: attachment)
//        nameText.insert(attachmentString, at: 1)
//
        result.append(nameText)
        
        self.attributedText = result
    }
}
