//
//  ChurchCommentCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 12/10/21.
//

import UIKit

class ChurchCommentCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var starComm1: UIImageView!
    @IBOutlet weak var starComm2: UIImageView!
    @IBOutlet weak var starComm3: UIImageView!
    @IBOutlet weak var starComm4: UIImageView!
    @IBOutlet weak var starComm5: UIImageView!
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
