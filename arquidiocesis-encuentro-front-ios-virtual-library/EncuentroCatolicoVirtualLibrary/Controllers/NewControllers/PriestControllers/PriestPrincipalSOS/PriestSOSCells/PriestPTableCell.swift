//
//  PriestPTableCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestPTableCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var lblSolicitante: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblFaithfulName: UILabel!
    @IBOutlet weak var lblStatusService: UILabel!
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
