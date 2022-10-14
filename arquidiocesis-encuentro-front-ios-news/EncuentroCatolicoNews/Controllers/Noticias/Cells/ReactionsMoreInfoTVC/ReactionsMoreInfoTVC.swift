//
//  ReactionsMoreInfoTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class ReactionsMoreInfoTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public var nameLabel: UILabel!
    @IBOutlet public var reactionImage: UIImageView!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        userImage.image = nil
        nameLabel.text = nil
        
    }
    
    //MARK: - Methods
    private func setUpView() {
        userImage.makeRounded()
    }
    
}
