//
//  LocationsTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class LocationsTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public var nameLabel: UILabel!
    @IBOutlet public var directionsLabel: UILabel!
    
    @IBOutlet public var locationImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "locationIconTable".getImage()
        
        return imageView
    }()
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        directionsLabel.text = nil
        nameLabel.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        self.selectionStyle = .none
    }
    
}
