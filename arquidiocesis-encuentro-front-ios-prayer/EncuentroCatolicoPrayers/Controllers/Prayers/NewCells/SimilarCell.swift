
//
//  SimilarCell.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 30/09/21.
//

import UIKit

class SimilarCell: UITableViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblNamePray: UILabel!
    @IBOutlet weak var iconGo: UIImageView!
    
// MARK: LIFE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
