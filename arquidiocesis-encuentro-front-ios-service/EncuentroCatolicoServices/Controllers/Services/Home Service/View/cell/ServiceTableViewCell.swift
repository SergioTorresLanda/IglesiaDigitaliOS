//
//  ServiceTableViewCell.swift
//  Services
//
//  Created by Miguel Eduardo  Valdez Tellez  on 21/04/21.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
