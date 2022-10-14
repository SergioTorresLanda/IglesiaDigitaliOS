//
//  DeleteAlert.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 19/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class DeleteAlert: UIView {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var alertView: UIView!
    @IBOutlet public weak var deleteView: UIView!
    @IBOutlet public weak var deleteButton: UIButton!
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
        Bundle(for: DeleteAlert.self).loadNibNamed("DeleteAlert", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMaxYCorner], radius: 40)
        deleteView.setCorner(cornerRadius: 20
        )
    }
}
