//
//  FavoriteChurchCells.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 27/04/21.
//

import UIKit

class FavoriteChurchCells: UICollectionViewCell {
    
    @IBOutlet weak var imgView  : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 10
    }

}
