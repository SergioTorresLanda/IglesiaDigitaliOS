//
//  RadioBtnCollectionViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 21/01/22.
//

import UIKit

class RadioBtnCollectionViewCell: UICollectionViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var emptyCircle: UIImageView!
    @IBOutlet weak var fillCircle: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRadio: UIButton!
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
