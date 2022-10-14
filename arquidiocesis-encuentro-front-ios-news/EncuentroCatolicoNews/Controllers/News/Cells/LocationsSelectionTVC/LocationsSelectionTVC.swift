//
//  LocationsSelectionTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class LocationsSelectionTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var locationImage: UIImageView!
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var deleteButton: UIButton!
    @IBOutlet public weak var locationName: UILabel!
    
    @IBOutlet public weak var deleteImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "deleteCircleIcon".getImage()
        
        return imageView
    }()
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        locationImage.image = nil
        locationName.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        containerView.roundCorners(corners: [.layerMaxXMaxYCorner], radius: 40)
        containerView.setBorder(borderColor: UIColor(red: 0.91, green: 0.89, blue: 0.91, alpha: 1.00))
    }
    
}
