//
//  coursesCVC.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 26/03/21.
//

import UIKit

class coursesCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblSubtitle  : UILabel!
    @IBOutlet weak var btnHearth    : UIButton!
    @IBOutlet weak var imgIcon      : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgIcon.makeCircular()
    }

}
