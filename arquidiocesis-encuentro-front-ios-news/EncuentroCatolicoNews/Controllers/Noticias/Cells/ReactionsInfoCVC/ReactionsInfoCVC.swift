//
//  ReactionsInfoCVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class ReactionsInfoCVC: UICollectionViewCell {

    //MARK: - @IBoutlets
    @IBOutlet public var reactionImage: UIImageView!
    @IBOutlet public var reactionCountLabel: UILabel!
    @IBOutlet public var selectedView: UIView!
    @IBOutlet public weak var labelCenter: NSLayoutConstraint!
    
    //MARK: - Properties
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                selectedView.isHidden = false
            } else {
                selectedView.isHidden = true
           }
        }
    }
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        
        reactionCountLabel.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        selectedView.setCorner(cornerRadius: 2)
    }

}
