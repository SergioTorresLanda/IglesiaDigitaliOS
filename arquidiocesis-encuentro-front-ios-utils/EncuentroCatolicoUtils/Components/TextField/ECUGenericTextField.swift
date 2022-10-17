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
    var padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    var leftIcon: UIImage? {
        didSet {
            self.setLeftIcon(leftIcon)
            self.padding.left = self.leftView?.frame.size.width ?? 10
        }
    }
    var leftAction: ECGenericAction?
    
    var rightIcon: UIImage? {
        didSet {
            self.setRightIcon(rightIcon)
            self.padding.right = self.rightView?.frame.size.width ?? 10
        }
    }
    var rightAction: ECGenericAction?
    
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
    
    //MARK: - Events
    @objc private func onClick(_ sender: UIView) {
        sender.tag == 0 ? leftAction?() : rightAction?()
    }
}

//MARK: - Private functions
extension ECUGenericTextField {
    private func setLeftIcon(_ icon: UIImage?) {
        setIcon(icon, isRight: false)
    }
    
    private func setRightIcon(_ icon: UIImage?) {
        setIcon(icon, isRight: true)
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
