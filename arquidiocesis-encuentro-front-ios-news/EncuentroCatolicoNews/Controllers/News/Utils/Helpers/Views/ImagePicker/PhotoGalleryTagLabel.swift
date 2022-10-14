//
//  PhotoGalleryTagLabel.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class PhotoGalleryTagLabel: UILabel {

    private struct Configuration {
        let font: UIFont
        let textColor: UIColor
        let backgroundColor: UIColor

        init(font: UIFont? = nil, textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
            self.font = font ?? UIFont.forTagLabel
            self.textColor = textColor ?? UIColor.white
            self.backgroundColor = backgroundColor ?? UIColor.Palette.blue
        }
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAppearance()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpAppearance()
    }

    // MARK: - Properties

    internal var textAttributes: [NSAttributedString.Key: Any] = [:] {
        didSet {
            configuration = Configuration(
                font: textAttributes[.font] as? UIFont,
                textColor: textAttributes[.foregroundColor] as? UIColor,
                backgroundColor: textAttributes[.backgroundColor] as? UIColor
            )
            font = configuration.font
            textColor = configuration.textColor
            setNeedsDisplay()
        }
    }

    private var configuration = Configuration()

    // MARK: - UIView

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.clear(bounds)

        // Draw the blue circle in the background
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = max(bounds.width, bounds.height) / 2

        let circle = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        configuration.backgroundColor.setFill()
        circle.fill()

        super.draw(rect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: contentEdgeInsets.left + size.width + contentEdgeInsets.right,
            height: contentEdgeInsets.top + size.height + contentEdgeInsets.bottom
        )
    }

    // MARK: - Private

    private let contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    private func setUpAppearance() {
        clipsToBounds = false
        textAlignment = .center
        textAttributes = [:]  // Use the default appearance
    }

}

