//
//  AddCommunitiesTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 24/08/21.
//

import UIKit

class AddCommunitiesTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AddCommunitiesTableViewCell"
    static let nib = UINib(nibName: AddCommunitiesTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: AddCommunitiesTableViewCell.self))
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
