//
//  EditImagesTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class EditImagesTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var contentImage: UIImageView!
    @IBOutlet public weak var deleteButton: UIButton!
    
    @IBOutlet public weak var cameraImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "camaraIcon".getImage()
        
        return imageView
    }()
    
    @IBOutlet public weak var deleteImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "deleteCircleIcon".getImage()
        
        return imageView
    }()
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public override func prepareForReuse() {
        contentImage.image = nil
    }
    
}
