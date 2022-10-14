//
//  FlexibleTextView.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 21/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class FlexibleTextView: UITextView {

    //MARK: - Properties
    public var maxHeight: CGFloat = 0.0
    
    private let placeholderLabel: UILabel = {
        let placeholder = UILabel()
        placeholder.backgroundColor = .clear
        placeholder.isUserInteractionEnabled = false
        placeholder.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        
        return placeholder
    }()
    
    public var placeholder: String? {
        get { return placeholderLabel.text }
        set { placeholderLabel.text = newValue }
    }
    
    override public var text: String! {
        didSet {
            invalidateIntrinsicContentSize()
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
    override public var font: UIFont? {
        didSet {
            placeholderLabel.font = font
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        if size.height == UIView.noIntrinsicMetric {
            layoutManager.glyphRange(for: textContainer)
            size.height = layoutManager.usedRect(for: textContainer).height + textContainerInset.top + textContainerInset.bottom
        }
        
        if maxHeight > 0.0 && size.height > maxHeight {
            size.height = maxHeight
            
            if !isScrollEnabled {
                isScrollEnabled = true
            }
        } else if isScrollEnabled {
            isScrollEnabled = false
        }
        
        return size
    }
    
    //MARK: - Life cycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    //MARK: - Methods
    private func commonInit() {
        self.textContainerInset = UIEdgeInsets(top: 0, left: 4, bottom: 8, right: 4)
        self.contentInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        
        showsVerticalScrollIndicator = false
        isScrollEnabled = false
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        NotificationCenter.default.addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)),
                                               name: UITextView.textDidChangeNotification, object: self)
        
        placeholderLabel.font = font
        addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    @objc private func textDidChange(_ note: Notification) {
        invalidateIntrinsicContentSize()
        placeholderLabel.isHidden = !text.isEmpty
    }
}

