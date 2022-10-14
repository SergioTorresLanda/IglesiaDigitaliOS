//
//  IntentionCellDetail.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 15/09/21.
//

import UIKit

class IntentionCellDetail: UITableViewCell {

    @IBOutlet weak var lblIntention: UILabel!
    @IBOutlet weak var lblTypeIntention: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
