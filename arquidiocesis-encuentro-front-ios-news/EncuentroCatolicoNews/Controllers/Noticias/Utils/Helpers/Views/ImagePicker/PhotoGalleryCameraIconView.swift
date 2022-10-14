//
//  PhotoGalleryCameraIconView.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class PhotoGalleryCameraIconView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubviews()
    }

    private lazy var imageView: UIImageView = {
        let camera = "imagePickerCamera".getImage()
        return UIImageView(image: camera)
    }()

    private func setUpSubviews() {
        backgroundColor = UIColor.white
        addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
    }

}

