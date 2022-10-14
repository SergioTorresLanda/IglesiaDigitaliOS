//
//  EmptyTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 11/08/21.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "EmptyTableViewCell"
    static let nib = UINib(nibName: EmptyTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: EmptyTableViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
