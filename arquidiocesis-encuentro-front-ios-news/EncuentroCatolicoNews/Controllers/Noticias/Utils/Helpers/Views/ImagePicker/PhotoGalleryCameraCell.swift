//
//  PhotoGalleryCameraCell.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class PhotoGalleryCameraCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubviews()
    }

    private lazy var cameraIconView: UIView = PhotoGalleryCameraIconView()

    private func setUpSubviews() {
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(cameraIconView)

        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        cameraIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cameraIconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cameraIconView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cameraIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}

