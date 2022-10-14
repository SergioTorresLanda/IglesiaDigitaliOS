//
//  ChurchCellCVC.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 23/04/21.
//

import UIKit

class ChurchCellCVC: UICollectionViewCell {

    @IBOutlet weak var imgView      : UIImageView!
    @IBOutlet weak var lblTitle     : UILabel!
    @IBOutlet weak var lblAddress   : UILabel!
    @IBOutlet weak var lblDistance  : UILabel!
    @IBOutlet weak var cellView     : UIView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        cellView.layer.shadowOpacity = 0.1
        cellView.layer.shadowRadius = 5
        cellView.layer.cornerRadius = 10
    }

}

