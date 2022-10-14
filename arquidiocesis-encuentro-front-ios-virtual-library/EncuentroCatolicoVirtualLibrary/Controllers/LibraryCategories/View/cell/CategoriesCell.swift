//
//  CategoriesCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by 4n4rk0z on 16/04/21.
//

import UIKit

class CategoriesCell: UITableViewCell {
    
   // static let reuseIdentifier = "CategoriesCell"

    @IBOutlet weak var lblTitle: UILabel!
   // static let nib = UINib(nibName: CategoriesCell.reuseIdentifier, bundle: Bundle.local)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
