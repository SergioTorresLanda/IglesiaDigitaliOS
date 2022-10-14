//
//  ChurhesCardCellDiacono.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 12/09/21.
//

import UIKit

class ChurhesCardCellDiacono: UICollectionViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var churchImg: UIImageView!
    @IBOutlet weak var lblNameChurch: UILabel!
    @IBOutlet weak var btnDeleteChurch: UIButton!
    @IBOutlet weak var subCardView: UIView!
    
//  MARK: LIFE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
