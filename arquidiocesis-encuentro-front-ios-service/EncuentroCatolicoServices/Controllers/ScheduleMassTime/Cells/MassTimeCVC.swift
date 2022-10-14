//
//  MassTimeCVC.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 28/04/21.
//

import UIKit

class MassTimeCVC: UICollectionViewCell {
    
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var cellView: UIView! 
        

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 10
    }

}
