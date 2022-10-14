//
//  CongregationCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import UIKit

class CongregationCell: UITableViewCell {

// MARK: @IBOUTLETS -
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var goIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
