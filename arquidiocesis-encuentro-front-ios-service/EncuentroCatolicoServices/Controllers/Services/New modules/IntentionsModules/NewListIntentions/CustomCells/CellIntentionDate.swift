//
//  CellIntentionDate.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit

class CellIntentionDate: UITableViewCell {

// MARK: - @IBOUTELTS -
    @IBOutlet weak var cardDateCell: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var calendarIcon: UIImageView!
    @IBOutlet weak var lineView: UIView!
    
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
