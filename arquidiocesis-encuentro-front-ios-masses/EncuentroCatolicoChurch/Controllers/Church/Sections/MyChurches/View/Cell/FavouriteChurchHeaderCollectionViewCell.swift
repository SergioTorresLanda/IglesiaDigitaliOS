//
//  FavouriteChurchHeaderCollectionViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Cruz on 03/05/21.
//

import UIKit

protocol AddChourchButtonDelegate: AnyObject {
    func didPressAddButton(_ tag: Int)
}
class FavouriteChurchHeaderCollectionViewCell: UICollectionViewCell {
    weak var delegate: AddChourchButtonDelegate!
    @IBOutlet var addChurchView: UIView!
    @IBOutlet weak var addChourcButton: UIButton!
    static let reuseIdentifier = "FavouriteChurchHeaderCollectionViewCell"
    static let nib = UINib(nibName: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: FavouriteChurchHeaderCollectionViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func addChurchAction(_ sender: UIButton) {
        self.delegate?.didPressAddButton(sender.tag)
    }
}
