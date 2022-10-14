//
//  MyChurchHeaderCollectionViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Cruz on 03/05/21.
//

import UIKit

class MyChurchHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet var changeChurch: UIButton!
    static let reuseIdentifier = "MyChurchHeaderCollectionViewCell"
    @IBOutlet var titleSection: UILabel!
   
    static let nib = UINib(nibName: MyChurchHeaderCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: MyChurchHeaderCollectionViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func changeAction(_ sender: Any) {
    }
    
}
