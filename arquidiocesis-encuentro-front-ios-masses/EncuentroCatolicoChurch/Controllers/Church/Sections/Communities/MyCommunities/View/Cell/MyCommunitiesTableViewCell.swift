//
//  MyCommunitiesTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import UIKit

class MyCommunitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUPView()
    }
    func setUPView() {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
