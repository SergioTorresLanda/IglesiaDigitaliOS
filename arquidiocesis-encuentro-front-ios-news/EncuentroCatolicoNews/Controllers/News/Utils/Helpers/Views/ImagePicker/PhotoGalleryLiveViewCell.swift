//
//  PhotoGalleryLiveViewCell.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

final class PhotoGalleryLiveViewCell: UICollectionViewCell {

    let previewView = LiveView()

    private lazy var cameraIconView: UIImageView = {
        let camera = "cameraIcon".getImage()
        return UIImageView(image: camera)
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = Bundle.init(for: InitViewViewController.self).localizedString(forKey: "imagePicker.button.camera", value: "", table: nil).uppercased()
        label.font = UIFont.forCameraButton
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    private func setupViews() {
        isAccessibilityElement = true

        contentView.addSubview(previewView)
        previewView.translatesAutoresizingMaskIntoConstraints = false
        previewView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        previewView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        previewView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        contentView.addSubview(cameraIconView)
        contentView.addSubview(textLabel)

        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        cameraIconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cameraIconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: cameraIconView.bottomAnchor, constant: 10).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

