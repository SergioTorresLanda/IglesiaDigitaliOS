//
//  FavEmptyTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 11/08/21.
//

import UIKit

class FavEmptyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FavEmptyTableViewCell"
    static let nib = UINib(nibName: FavEmptyTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: FavEmptyTableViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
