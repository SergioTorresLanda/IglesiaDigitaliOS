//
//  ListDetailCell.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class ListDetailCell: UITableViewCell {
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblNameService: UILabel!
    @IBOutlet weak var lblSolicitante: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var goIcon: UIImageView!
    @IBOutlet weak var lblStateç: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
