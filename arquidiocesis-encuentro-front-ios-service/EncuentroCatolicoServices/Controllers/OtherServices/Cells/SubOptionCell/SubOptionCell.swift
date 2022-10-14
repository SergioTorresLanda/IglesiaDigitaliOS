//
//  SubOptionCell.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 23/04/21.
//

import UIKit

class SubOptionCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView : UIImageView! 
    @IBOutlet weak var cellView: UIView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cellView.layer.shadowOpacity = 0.1
        cellView.layer.shadowRadius = 5
        cellView.layer.cornerRadius = 10
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
