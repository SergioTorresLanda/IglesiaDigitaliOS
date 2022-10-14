//
//  RadioButton.swift
//  EncuentroCatolicoProfile
//
//  Created by René Sandoval on 21/04/21.
//

import UIKit

@IBDesignable
public class RadioButton: UIButton {
    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    internal var buttonTextLabel = UILabel()
    private var width: CGFloat = 20
    private var height: CGFloat = 20

    // MARK: - @IBInspectable properties

    @IBInspectable public var deselectedColor: UIColor = UIColor.darkGray {
        didSet {
            outerCircleLayer.strokeColor = deselectedColor.cgColor
        }
    }

    @IBInspectable public var selectedColor: UIColor = UIColor.blue {
        didSet {
            setFillState()
        }
    }

    @IBInspectable public var outerCircleLineWidth: CGFloat = 1.0 {
        didSet {
            setCircleLayouts()
        }
    }

    @IBInspectable public var circlePadding: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }

    @IBInspectable public var titleText: String = "" {
        didSet {
            buttonTextLabel.text = titleText
        }
    }

    @IBInspectable public var titleFontType: String = "Roboto-Regular" {
        didSet {
            buttonTextLabel.font = UIFont(name: titleFontType, size: titleSize)
        }
    }

    @IBInspectable public var titleSize: CGFloat = 16.0 {
        didSet {
            buttonTextLabel.font = UIFont(name: titleFontType, size: titleSize)
        }
    }

    @IBInspectable public var buttonHeight: CGFloat = 20 {
        didSet {
            height = buttonHeight
        }
    }

    @IBInspectable public var buttonWidth: CGFloat = 20 {
        didSet {
            width = buttonWidth
        }
    }

    // MARK: - Private properties

    internal var setCircleRadius: CGFloat {
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }

    private var setCircleFrame: CGRect {
        return CGRect(x: 0, y: 0, width: width, height: height)
    }

    private var outerCirclePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }

    private var innerCirclePath: UIBezierPath {
        let trueGap = circlePadding + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
    }

    // MARK: Initialisation

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialise()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialise()
    }

    private func initialise() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = deselectedColor.cgColor
        layer.addSublayer(outerCircleLayer)

        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)

        buttonTextLabel.frame = CGRect(x: width + 10, y: 0, width: 100, height: height + 5)
        addSubview(buttonTextLabel)
        setFillState()
    }

    // MARK: - Private methods

    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = outerCirclePath.cgPath

        innerCircleLayer.frame = bounds
        innerCircleLayer.path = innerCirclePath.cgPath

        buttonTextLabel.frame = CGRect(x: width + 10, y: 0, width: 100, height: height + 5)
    }

    private func setFillState() {
        if isSelected {
            outerCircleLayer.strokeColor = selectedColor.cgColor
            innerCircleLayer.fillColor = selectedColor.cgColor
            buttonTextLabel.textColor = selectedColor
        } else {
            outerCircleLayer.strokeColor = deselectedColor.cgColor
            innerCircleLayer.fillColor = UIColor.clear.cgColor
            buttonTextLabel.textColor = deselectedColor
        }
    }

    // MARK: - Overridden methods

    override public func prepareForInterfaceBuilder() {
        initialise()
    }

    override public func layoutSubviews() {
        setCircleLayouts()
    }

    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}
