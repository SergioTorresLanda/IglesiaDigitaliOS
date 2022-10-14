//
//  CommunityTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 11/08/21.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommunityTableViewCell"
    static let nib = UINib(nibName: CommunityTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: CommunityTableViewCell.self))
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
