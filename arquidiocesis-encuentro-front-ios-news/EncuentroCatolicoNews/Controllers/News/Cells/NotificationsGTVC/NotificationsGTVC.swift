//
//  NotificationsGTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Consultor on 14/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class NotificationsGTVC: UITableViewCell {
    
    //MARK: - @IBoutlets
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var contentLabel: UILabel!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var editPostButton: UIButton!
    @IBOutlet public weak var background: UIView!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        userImage.image = nil
        contentLabel.text = nil
        dateLabel.text = nil
    }
    
}
