//
//  CommentsCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import UIKit

class CommentsCell: UITableViewCell {

// MARK: @IBOUTLETS -
    @IBOutlet weak var cardCommentView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
