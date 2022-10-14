//
//  ReactionsCVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class ReactionsCVC: UICollectionViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var reactionImage: UIImageView!
    @IBOutlet public weak var reactionLabel: UILabel!
    @IBOutlet public weak var separator: UIView!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        
        reactionLabel.text = nil
    }

}
