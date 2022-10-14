//
//  ReactionsPost.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 25/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Lottie
import RealmSwift

public class ReactionsPost: UIView {
    
    //MARK: - Properties
    private let iconHeight: CGFloat = 40
    private let padding: CGFloat = 5
    
    //MARK: - Life Cycle
    override public init(frame: CGRect) {
        super.init(frame:frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    //MARK: - Methods
    private func createAnimation(id: Int, json: String) -> AnimationView {
        var animation = AnimationView()
        if let url = URL(string: json) {
            animation.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            animation = AnimationView(url: url, closure: { _ in animation.play() })
            animation.contentMode = .scaleToFill
            animation.loopMode = .loop
        }

        animation.accessibilityIdentifier = String(id)
        return animation
    }
    
    private func createAnimationsArray() -> [AnimationView] {
        guard let feelings = retrieveFromRealm() else { return [] }
        var resultArray = [AnimationView]()
        feelings.forEach { (feeling) in
            resultArray.append(createAnimation(id: feeling.id, json: feeling.json))
        }
        
        storedData.defaultReactionId = feelings.first?.id ?? 0
        
        return resultArray
    }
    
    private func retrieveFromRealm() -> [ReactionsRealm]? {
        let results = RealmManager.fetchData(object: ReactionsRealm.self)
        return results
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        
        let animationsArray = createAnimationsArray()
        
        let stackView = UIStackView(arrangedSubviews: animationsArray)
        stackView.distribution = .fillEqually
        
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        self.addSubview(stackView)
        
        let numIcons = CGFloat(animationsArray.count)
        let width =  (numIcons * iconHeight) + ((numIcons + 1) * padding)
        let height = iconHeight + 2 * padding
        
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.layer.cornerRadius = self.frame.height / 2
        
        self.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = self.frame
    }
}

