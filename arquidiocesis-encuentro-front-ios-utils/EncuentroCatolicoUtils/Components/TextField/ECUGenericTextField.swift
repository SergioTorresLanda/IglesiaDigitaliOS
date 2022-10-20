//
//  ECGenericTextField.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import UIKit

public typealias ECGenericAction = () -> Void

open class ECUGenericTextField: UITextField {
    //MARK: - Properties
    public var leftIcon: UIImage? {
        didSet {
            guard oldValue != leftIcon else {
                return
            }
            
            guard let leftIcon = leftIcon else {
                setIcon(nil, isRight: false)
                return
            }

            self.leftImage = leftIcon
        }
    }
    public var leftIconTint: UIColor?
    public var leftAction: ECGenericAction?
    public var rightIcon: UIImage? {
        didSet {
            guard oldValue != rightIcon else {
                return
            }
            
            guard let rightIcon = rightIcon else {
                setIcon(nil, isRight: true)
                return
            }

            self.rightImage = rightIcon
        }
    }
    public var rightIconTint: UIColor?
    public var rightAction: ECGenericAction?
    public var border: ECUBorder?
    
    var padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private var rightImage: UIImage? {
        didSet {
            guard oldValue != rightIcon else {
                return
            }
            
            setRightIcon()
        }
    }
    private var leftImage: UIImage? {
        didSet {
            guard oldValue != leftIcon else {
                return
            }
            
            setLeftIcon()
        }
    }
    //MARK: - Life Cycle
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()

        setupBorder()
        setLeftIcon()
        setRightIcon()
    }
    //MARK: - Events
    @objc private func onClick(_ sender: UIView) {
        sender.tag == 0 ? leftAction?() : rightAction?()
    }
}

//MARK: - Private functions
extension ECUGenericTextField {
    private func setupBorder() {
        guard self.frame != .zero,
              let border = self.border else {
            return
        }
        
        self.addBorder(border: border)
        self.border = nil
    }
    
    private func setLeftIcon() {
        guard self.frame != .zero,
              let icon = self.leftImage else {
            return
        }
        
        setIcon(icon, isRight: false)
        self.padding.left = self.leftView?.frame.size.width ?? 10
        self.leftImage = nil
    }
    
    private func setRightIcon() {
        guard self.frame != .zero,
              let icon = self.rightImage else {
            return
        }
        
        setIcon(icon, isRight: true)
        self.padding.right = self.rightView?.frame.size.width ?? 10
        self.rightImage = nil
    }
    
    private func setIcon(_ icon: UIImage?, isRight: Bool) {
        guard icon != nil else {
            if isRight {
                self.rightView = nil
                return
            }
            
            self.leftView = nil
            return
        }
        
        let iconSize = self.frame.size.height * 0.5
        let rightPadding: CGFloat = 10
        let iconView = UIImageView(frame:
                                    CGRect(x: rightPadding, y: iconSize / 2, width: iconSize, height: iconSize))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        
        button.tag = isRight ? 1 : 0
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        iconView.tintColor = isRight ? rightIconTint : leftIconTint
        iconView.image = icon
        iconView.contentMode = .scaleAspectFit
        
        let iconContainerView: UIView = UIView(frame:
                       CGRect(x: 20, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        
        iconContainerView.addSubview(iconView)
        iconContainerView.addSubview(button)
        
        if isRight {
            rightView = iconContainerView
            rightViewMode = .always
        } else {
            leftView = iconContainerView
            leftViewMode = .always
        }
    }
}
