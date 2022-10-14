//
//  SellectedModulesTableViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 24/06/21.
//

import UIKit

class SellectedModulesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabesl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabesl.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
