//
//  GalleryVideoCell.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

internal final class GalleryVideoCell: GalleryPhotoCell {

    private let videoPropertyView = VideoPropertyView()

    override func setUpSubviews() {
        super.setUpSubviews()

        contentView.addSubview(videoPropertyView)
        videoPropertyView.translatesAutoresizingMaskIntoConstraints = false
        videoPropertyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        videoPropertyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        videoPropertyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        videoPropertyView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    override func configure(
        with asset: PHAsset,
        taggedText: String? = nil,
        configuration: ImagePickerConfigurable?) {

        super.configure(
            with: asset,
            taggedText: taggedText,
            configuration: configuration)
        videoPropertyView.configure(style: configuration)
        videoPropertyView.configure(duration: asset.duration)
        videoPropertyView.setSelected(taggedText != nil)
    }
}

