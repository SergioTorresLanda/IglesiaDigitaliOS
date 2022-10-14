//
//  ImagesCVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 04/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift

public class ImagesCVC: UICollectionViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var contentImage: UIImageView!
    @IBOutlet public weak var extraImagesView: UIView!
    @IBOutlet public weak var extraImagesLabel: UILabel!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func prepareForReuse() {
        contentImage.image = nil
        extraImagesLabel.text = nil
    }
    
}
