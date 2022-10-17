//
//  PTCUShadowView.swift
//  PTCommonUtils
//
//  Created by Alejandro Orihuela on 03/12/21.
//

import UIKit

@IBDesignable
open class ECUView: UIView {
    //MARK: - @IBInspectable
    ///Set corner by proportinal height __Default:__ 0.2
    @IBInspectable
    public var cornerRadius: CGFloat = 0.2 {
        didSet { layoutIfNeeded() }
    }
    
    //MARK: - Properties
    ///Setup the shadow type you want
    public var shadowSelected: ECUSizeType? {
        didSet { layoutIfNeeded() }
    }

    //MARK: - Life Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height * cornerRadius
        setupShadow()
    }
}

//MARK: - Private functions
extension ECUView {
    private func setupShadow() {
        guard let shadowSelected = shadowSelected else {
              return
        }
        
        dropShadow(shadowType: shadowSelected)
    }
}
