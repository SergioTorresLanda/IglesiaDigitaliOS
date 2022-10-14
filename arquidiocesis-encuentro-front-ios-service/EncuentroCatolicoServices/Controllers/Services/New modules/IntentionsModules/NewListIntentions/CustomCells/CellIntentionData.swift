//
//  CellIntentionData.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit

class CellIntentionData: UITableViewCell {
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var cardDataCell: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var goIcon: UIImageView!
    @IBOutlet weak var lblPriestJoy: UILabel!
    @IBOutlet weak var lblName: UILabel!

// MARK: LIFE CYCLE CELL FUNCS -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
