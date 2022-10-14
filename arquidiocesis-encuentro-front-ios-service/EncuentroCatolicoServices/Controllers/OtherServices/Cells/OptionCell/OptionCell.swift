//
//  OptionCell.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 23/04/21.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView : UIImageView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
