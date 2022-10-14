//
//  GroupsCVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class GroupsCVC: UICollectionViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var infoImage: UIImageView!
    @IBOutlet public weak var infoLabel: UILabel!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        infoImage.image = nil
        infoLabel.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        infoImage.setCorner(cornerRadius: 30)
        infoImage.setBorder(borderColor: UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00))
    }
}
