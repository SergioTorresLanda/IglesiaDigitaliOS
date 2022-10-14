//
//  LineLabelTextField.swift
//  EncuentroCatolicoProfile
//
//  Created by René Sandoval on 13/04/21.
//

import UIKit

class LineLabelTextField: UITextField {
    private var lineView: UIView!
    private var label: UILabel!
    private var labelError: UILabel!

    var lineHeight: CGFloat = 1.0 {
        didSet {
            updateLineView()
            setNeedsDisplay()
        }
    }

    var labelColor: UIColor = .black {
        didSet {
            label.textColor = labelColor
            setNeedsDisplay()
        }
    }

    var labelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            label.font = labelFont
            font = labelFont
            setNeedsDisplay()
        }
    }

    var textLabel: String = "" {
        didSet {
            label.text = textLabel
            addLabel()
        }
    }

    var textErrorLabel: String = "" {
        didSet {
            self.labelError.text = self.textErrorLabel
            
            if self.textErrorLabel == "" {
                self.labelError.isHidden = true
            }
            
            self.labelError.isHidden = false
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: CGRect.zero)
        addErrorLabel()
        createLineView()
    }

    open dynamic var lineColor: UIColor = .lightGray {
        didSet {
            updateLineView()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        label = UILabel(frame: CGRect.zero)
        lineView = UIView(frame: CGRect.zero)
        createLineView()
    }

    private func addLabel() {
        if label.text != "" {
            label.textColor = labelColor
            label.font = UIFont(name: "Roboto-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.clipsToBounds = true
            label.frame = CGRect(x: 0, y: 0, width: label.frame.width + 4, height: label.frame.height + 2)
            label.textAlignment = .center
            addSubview(label)
            label.bottomAnchor(equalTo: topAnchor)

            bringSubviewToFront(subviews.last!)
            setNeedsDisplay()
        }
    }

    private func addErrorLabel() {
        labelError = UILabel(frame: CGRect.zero)
        if labelError.text != "" {
            labelError.textColor = UIColor(red: 253 / 255, green: 13 / 255, blue: 27 / 255, alpha: 1.0)
            labelError.font = UIFont(name: "Roboto-Light", size: 12.0) ?? UIFont.systemFont(ofSize: 12, weight: .light)
            labelError.translatesAutoresizingMaskIntoConstraints = false
            labelError.clipsToBounds = true
            labelError.frame = CGRect(x: 0, y: 0, width: label.frame.width + 4, height: label.frame.height + 2)
            labelError.textAlignment = .left
            addSubview(labelError)
            labelError.bottomAnchor(equalTo: bottomAnchor, constant: 20)

            bringSubviewToFront(subviews.last!)
            setNeedsDisplay()
        }
    }

    fileprivate func createLineView() {
        if lineView == nil {
            let lineView = UIView()
            lineView.isUserInteractionEnabled = false
            self.lineView = lineView
            configureDefaultLineHeight()
        }

        lineView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        addSubview(lineView)
    }

    fileprivate func updateLineView() {
        guard let lineView = lineView else {
            return
        }

        lineView.frame = lineViewRectForBounds(bounds)
        updateLineColor()
    }

    open func lineViewRectForBounds(_ bounds: CGRect) -> CGRect {
        let height = label.text == "" ? 7.5 : lineHeight
        return CGRect(x: 0, y: bounds.size.height + height, width: bounds.size.width, height: lineHeight)
    }

    fileprivate func configureDefaultLineHeight() {
        let onePixel: CGFloat = 1.0 / UIScreen.main.scale
        lineHeight = 2.0 * onePixel
    }

    fileprivate func updateLineColor() {
        guard let lineView = lineView else {
            return
        }

        lineView.backgroundColor = lineColor
    }
}
