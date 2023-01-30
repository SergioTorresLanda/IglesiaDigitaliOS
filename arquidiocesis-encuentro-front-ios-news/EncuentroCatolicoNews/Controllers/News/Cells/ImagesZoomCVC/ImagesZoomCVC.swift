//
//  ImagesZoomCVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class ImagesZoomCVC: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var contentImage: UIImageView!


    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
//        contentImage.image = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
//        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture))
//        contentImage.addGestureRecognizer(pinch)
    }
    
    @objc private func pinchGesture(_ sender: UIPinchGestureRecognizer) {
//        if sender.state == .began || sender.state == .changed {
//            let currentScale = contentImage.frame.size.width / contentImage.bounds.size.width
//            let newScale = currentScale * sender.scale
//            let transform = CGAffineTransform(scaleX: newScale, y: newScale)
//            contentImage.transform = transform
//            sender.scale = 1
//        }
    }

}
