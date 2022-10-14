//
//  FeelingsCVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 14/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class FeelingsCVC: UICollectionViewCell {

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
        reactionImage.image = nil
        reactionLabel.text = nil
    }

}
