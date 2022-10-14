//
//  MyChurchCollectionViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Cruz on 03/05/21.
//

import UIKit
import SkeletonView

class MyChurchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var containerChurch: UIView!
    static let reuseIdentifier = "MyChurchCollectionViewCell"
    static let nib = UINib(nibName: MyChurchCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: MyChurchCollectionViewCell.self))
    @IBOutlet var titleChurch: UILabel!
    @IBOutlet var imageChurch: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageChurch.isSkeletonable = true
        titleChurch.isSkeletonable = true
        let placeHolderimage = UIImage(named: "church-placeholder", in: Bundle(for: FavouriteChurchCollectionViewCell.self), compatibleWith: nil)
        imageChurch.image = placeHolderimage
        containerChurch.layer.cornerRadius = 15
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1548789321)
        cardView.layer.shadowRadius = 7
        cardView.layer.shadowOpacity = 1
      
    }
}
