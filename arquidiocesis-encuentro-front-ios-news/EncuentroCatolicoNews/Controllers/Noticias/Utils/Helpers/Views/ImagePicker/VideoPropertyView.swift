//
//  VideoPropertyView.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class VideoPropertyView: UIView {

    private lazy var videoIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .white
        let image = "videoIcon".getImage()
        icon.image = image.withRenderingMode(.alwaysTemplate)
        return icon
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Book", size: 15.0)!
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()

    private var selected: Bool = false
    private var selectionBackgroundColor: UIColor = UIColor(red: 1.00, green: 0.63, blue: 0.22, alpha: 1.0)
    private var normalBackgroundColor: UIColor = UIColor.Palette.grey.withAlphaComponent(0.2)

    func configure(style: ImagePickerConfigurable?) {
        if let selectColor = style?.videoSelectionBackgroundColor {
            selectionBackgroundColor = selectColor
        }
        if let normalColor = style?.videoNormalBackgroundColor {
            normalBackgroundColor = normalColor
        }
        updateColor()
    }

    func configure(duration: TimeInterval) {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad

        if duration >= 3600 {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }

        durationLabel.text = formatter.string(from: duration)
    }

    func setSelected(_ isSelected: Bool) {
        selected = isSelected
        updateColor()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateColor() {
        if selected {
            backgroundColor = selectionBackgroundColor
        } else {
            backgroundColor = normalBackgroundColor
        }
    }

    private func setupViews() {
        backgroundColor = UIColor.Palette.grey.withAlphaComponent(0.2)

        addSubview(videoIcon)
        videoIcon.translatesAutoresizingMaskIntoConstraints = false
        videoIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        videoIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        videoIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        videoIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(durationLabel)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        durationLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

