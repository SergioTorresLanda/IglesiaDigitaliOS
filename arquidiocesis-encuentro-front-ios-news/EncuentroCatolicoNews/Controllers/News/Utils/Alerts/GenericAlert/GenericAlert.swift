//
//  GenericAlert.swift
//  RedSocialFramework
//
//  Created by Diego Alejandro Martinez on 29/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class GenericAlert: UIView {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var alertView: UIView!
    @IBOutlet public weak var errorMessageLabel: UILabel!
    @IBOutlet public weak var okButton: UIButton!
    @IBOutlet public weak var okView: UIView!
    
    //MARK: - Life cyle
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    //MARK: - Methods
    private func commonInit() {
        Bundle(for: GenericAlert.self).loadNibNamed("GenericAlert", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner], radius: 40)
        okView.setCorner(cornerRadius: 20)
    }
}
