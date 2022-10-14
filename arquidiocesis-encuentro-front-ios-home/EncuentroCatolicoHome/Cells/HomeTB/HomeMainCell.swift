//
//  HomeMainCell.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 20/08/21.
//

import UIKit

class HomeMainCell: UITableViewCell {

   
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var subCardView: UIView!
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var imgCard: UIImageView!
    @IBOutlet weak var lblBlue: UILabel!
    @IBOutlet weak var lblCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
