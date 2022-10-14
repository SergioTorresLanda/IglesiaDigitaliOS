//
//  NewServiceCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 08/10/21.
//

import UIKit

class NewServiceCell: UICollectionViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var iconChurch: UIImageView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
