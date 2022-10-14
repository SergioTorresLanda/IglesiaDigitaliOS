//
//  SocialTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import UIKit

class SocialTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    static let reuseIdentifier = "SocialTableViewCell"
    static let nib = UINib(nibName: SocialTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: SocialTableViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
