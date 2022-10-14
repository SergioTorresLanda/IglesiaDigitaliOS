//
//  UserSelectorTVC.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 01/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class UserSelectorTVC: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var userNameLabel: UILabel!
    @IBOutlet public weak var selectButton: UIButton!

    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
