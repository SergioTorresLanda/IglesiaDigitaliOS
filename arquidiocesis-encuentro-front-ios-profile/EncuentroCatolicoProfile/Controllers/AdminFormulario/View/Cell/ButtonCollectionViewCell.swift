//
//  ButtonCollectionViewCell.swift
//  ConfigAdmin
//
//  Created by Miguel Eduardo  Valdez Tellez  on 05/05/21.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "GenericCollectionViewCell"
    static let nib = UINib(nibName: GenericCollectionViewCell.reuseIdentifier, bundle: Bundle.local)

    @IBOutlet weak var viewButton: UIView!
    @IBAction func nextButton(_ sender: Any) {
        
    }
    @IBOutlet weak var collectionText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
}
