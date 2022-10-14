//
//  LocationImageCVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class LocationImageCVC: UICollectionViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var locationImage: UIImageView!
    @IBOutlet public weak var actionButton: UIButton!

    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func prepareForReuse() {
        locationImage.image = nil
    }

}
