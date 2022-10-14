//
//  CommentsAccesoryView.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 21/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class CommentsAccesoryView: CustomView {
    
    //MARK: - Properties
    private let customInputView: CustomView = {
        let customInputView = CustomView()
        customInputView.backgroundColor = UIColor.white
        customInputView.setShadow()
        return customInputView
    }()
    
    public let textView: FlexibleTextView = {
        let textView = FlexibleTextView()
        textView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.00)
        textView.font = UIFont(name: "Avenir-Book", size: 15)
        textView.textColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00)
        textView.tintColor = UIColor(red: 0.86, green: 0.60, blue: 0.31, alpha: 1.00)
        textView.setCorner(cornerRadius: 15)
        textView.placeholder = "Escribe un comentario..."
        textView.autocorrectionType = .yes
        textView.returnKeyType = .send
        
        return textView
    }()
    
    public let profileIcon: UIImageView = {
        let profileIcon = UIImageView()
        profileIcon.image = SocialNetworkConstant.shared.userImage.withRenderingMode(.alwaysOriginal)
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.makeRounded()
        return profileIcon
    }()
    
    public let commentIcon: UIImageView = {
        let commentI = UIImageView()
        commentI.image = "sendIcon".getImage()
        return commentI
    }()
    
    public let sendComment: UIButton = {
        let commentIcon = UIButton()
        commentIcon.backgroundColor = UIColor.clear
        return commentIcon
    }()
    
    
    
    //MARK: - Life cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        activateConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureUI()
        activateConstraints()
    }
    
    //MARK: - Methods
    private func configureUI() {
        addSubview(customInputView)
        customInputView.addSubview(textView)
        customInputView.addSubview(profileIcon)
        customInputView.addSubview(commentIcon)
        customInputView.addSubview(sendComment)
    }
    
    private func activateConstraints() {
        self.autoresizingMask = .flexibleHeight
        
        customInputView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customInputView.bottomAnchor.constraint(equalTo: bottomAnchor),
            customInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customInputView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.maxHeight = 80
        textView.trailingAnchor.constraint(
            equalTo: sendComment.leadingAnchor,
            constant: -10
        ).isActive = true
        
        textView.topAnchor.constraint(
            equalTo: customInputView.topAnchor,
            constant: 10
        ).isActive = true
        
        textView.bottomAnchor.constraint(
            equalTo: customInputView.layoutMarginsGuide.bottomAnchor,
            constant: -8
        ).isActive = true
        
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        profileIcon.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
        profileIcon.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
        profileIcon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        profileIcon.widthAnchor.constraint(equalTo: profileIcon.heightAnchor).isActive = true
        
        profileIcon.leadingAnchor.constraint(
              equalTo: customInputView.leadingAnchor,
              constant: 10
        ).isActive = true
          
        profileIcon.trailingAnchor.constraint(
            equalTo: textView.leadingAnchor,
            constant: -8
        ).isActive = true
        
        profileIcon.topAnchor.constraint(
            greaterThanOrEqualTo: customInputView.topAnchor,
            constant: 10
        ).isActive = true
          
        profileIcon.bottomAnchor.constraint(
            equalTo: customInputView.layoutMarginsGuide.bottomAnchor,
            constant: -8
        ).isActive = true
        
        sendComment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendComment.heightAnchor.constraint(equalToConstant: 25),
            sendComment.widthAnchor.constraint(equalToConstant: 25),
            sendComment.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            sendComment.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        commentIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentIcon.heightAnchor.constraint(equalTo: sendComment.heightAnchor),
            commentIcon.widthAnchor.constraint(equalTo: sendComment.widthAnchor),
            commentIcon.centerXAnchor.constraint(equalTo: sendComment.centerXAnchor),
            commentIcon.centerYAnchor.constraint(equalTo: sendComment.centerYAnchor)
        ])
        
    }
}

//MARK: - CustomView
public class CustomView: UIView {
    override public var intrinsicContentSize: CGSize {
        return CGSize.zero
    }
}
