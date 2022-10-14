//
//  SOSViewTableCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 14/06/21.
//

import UIKit

class SOSViewTableCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var emptyCircle: UIImageView!
    @IBOutlet weak var fillCircle: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
