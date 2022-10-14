//
//  AddMoreImagesTVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class AddMoreImagesTVC: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var addMoreImagesButton: UIButton!
    
    @IBOutlet public weak var addMoreImagesImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "agregarMas".getImage()
        
        return imageView
    }()

    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
