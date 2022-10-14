//
//  EditPostAlert.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 18/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class EditPostAlert: UIView {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var alertView: UIView!
    @IBOutlet public weak var continueEditingButton: UIButton!
    @IBOutlet public weak var discardButton: UIButton!
    
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
        Bundle(for: EditPostAlert.self).loadNibNamed("EditPostAlert", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner], radius: 40)
    }
}
