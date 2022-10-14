//
//  streamingCollectionCell.swift
//  EncuentroCatolicoLive
//
//  Created by Pablo Luis Velazquez Zamudio on 18/11/21.
//

import UIKit

class streamingCollectionCell: UICollectionViewCell {

// MARK: @IBOUTLETS -
    @IBOutlet weak var backgorundCard: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var streamImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
