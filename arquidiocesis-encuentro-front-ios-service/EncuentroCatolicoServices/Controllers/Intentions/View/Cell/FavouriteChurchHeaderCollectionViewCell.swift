//
//  FavouriteChurchHeaderCollectionViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Cruz on 03/05/21.
//

import UIKit

class FavouriteChurchHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet var addChurchView: UIView!
    static let reuseIdentifier = "FavouriteChurchHeaderCollectionViewCell"
    static let nib = UINib(nibName: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: FavouriteChurchHeaderCollectionViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addChurchAction(_ sender: Any) {
        
    }
}
