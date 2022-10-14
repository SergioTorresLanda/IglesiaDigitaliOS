//
//  MainChurchCommTableCell.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 23/02/22.
//

import UIKit

class MainChurchCommTableCell: UITableViewCell {
    
// MARK: @IBOTLETS -
    @IBOutlet weak var imgChurch: UIImageView!
    @IBOutlet weak var lblNameChurch: UILabel!
    @IBOutlet weak var btnGo: UIButton!
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
