//
//  followCell.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import UIKit

class followCell: UITableViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    var fll = false
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func followClick(_ sender: Any) {
        print("BB")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
