//
//  HomeServiceTableCell.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class HomeServiceTableCell: UITableViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblSection: UILabel!
    @IBOutlet weak var goIcon: UIImageView!
    
// MARK: LIFE CYCLE CELL -

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
