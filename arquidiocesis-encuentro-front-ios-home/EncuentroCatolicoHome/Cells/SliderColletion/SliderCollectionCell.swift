//
//  SliderCollectionCell.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 20/08/21.
//

import UIKit

protocol MyCellDelegate: NSObjectProtocol{
    func didPressCell(sender: Any)
}

class SliderCollectionCell: UICollectionViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var imgCustom: UIImageView!
    @IBOutlet weak var lblCustom: UILabel!
    @IBOutlet weak var btnCell: UIButton!
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
