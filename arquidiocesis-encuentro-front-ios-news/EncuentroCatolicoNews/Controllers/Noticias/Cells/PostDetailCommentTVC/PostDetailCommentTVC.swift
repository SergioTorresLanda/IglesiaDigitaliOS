//
//  PostDetailCommentTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 14/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class PostDetailCommentTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var commentView: UIView!
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var contentLabel: CustomLabel!
    @IBOutlet public weak var lookMoreCommentsButton: UIButton!
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        userImage.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
        contentLabel.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        userImage.makeRounded()
        
        commentView.setCorner(cornerRadius: 30)
        commentView.setBorder(borderColor: UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00))
    }
    
}
