//
//  EventsCVC.swift
//  EncuentroCatolicoLive
//
//  Created by Diego Martinez on 08/03/21.
//

import UIKit

class EventsCVC: UICollectionViewCell {
    
    @IBOutlet weak var cardImage        : UIImageView!
    @IBOutlet weak var dotView          : UIView!
    @IBOutlet weak var lblOn            : UILabel!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblSubtitle      : UILabel! 

    override func awakeFromNib() {
        super.awakeFromNib()
        dotView.layer.cornerRadius = dotView.frame.size.width/2
        cardImage.clipsToBounds = true
        cardImage.layer.cornerRadius = 10
        cardImage.layer.masksToBounds = true
        
    }

}
