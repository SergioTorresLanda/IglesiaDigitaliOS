//
//  Bundle.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Diego Martinez on 25/02/21.
//

import Foundation
import UIKit
public extension Bundle {
    static let local: Bundle = Bundle.init(for: VirtualViewController.self)
}

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right: -10)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func moveImageLeftTextCenter(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
            self.setImage(image.withRenderingMode(renderingMode), for: .normal)
            guard let imageViewWidth = self.imageView?.frame.width  else{return}
            guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
            self.contentHorizontalAlignment = .left
            let imageLeft = imagePadding - imageViewWidth / 2
            let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 130.0, bottom: 0.0, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft - 10 , bottom: 0.0, right: 0.0)
        }
    
    func moveImageLeftTextCenterSOSFiel(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
            self.setImage(image.withRenderingMode(renderingMode), for: .normal)
            guard let imageViewWidth = self.imageView?.frame.width  else{return}
            guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
            self.contentHorizontalAlignment = .left
            let imageLeft = imagePadding - imageViewWidth / 2
            let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 240.0, bottom: 0.0, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft - imagePadding , bottom: 0.0, right: 0.0)
        }
}


extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}
