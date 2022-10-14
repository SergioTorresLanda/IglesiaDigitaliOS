//
//  CollectionCellServicesH.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 30/08/21.
//

import UIKit

class CollectionCellServicesH: UICollectionViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var backCard: UIView!
    
// MARK: LIFE CELL CYCLE FUCNTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
// MARK: @IBACTIONS -
    @IBAction func removeAction(_ sender: Any) {
    }
    
}
