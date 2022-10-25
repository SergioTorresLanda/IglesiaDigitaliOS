//
//  PTCUShadowView.swift
//  PTCommonUtils
//
//  Created by Alejandro Orihuela on 03/12/21.
//

import UIKit

@IBDesignable
open class ECUView: UIView {
    //MARK: - Properties
    ///Setup the shadow type you want
    public var shadowSelected: ECUSizeType? {
        didSet { layoutIfNeeded() }
    }
    //MARK: - Life Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()

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
