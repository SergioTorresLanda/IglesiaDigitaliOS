//
//  GenericCollectionViewCell.swift
//  ConfigAdmin
//
//  Created by Miguel Eduardo  Valdez Tellez  on 06/05/21.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genericView: UIView!
    @IBOutlet weak var genericLabel: UILabel!
    static let reuseIdentifier = "ButtonCollectionViewCell"
    static let nib = UINib(nibName: ButtonCollectionViewCell.reuseIdentifier, bundle: Bundle.local)
    override func awakeFromNib() {
        super.awakeFromNib()
        genericLabel.adjustsFontSizeToFitWidth = true
        self.contentView.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }

}
