//
//  SubFormationTableViewCell.swift
//  tableViewExample
//
//  Created by Miguel Eduardo  Valdez Tellez  on 05/03/21.
//

import UIKit

class SubFormationTableViewCell: UITableViewCell {

    @IBOutlet weak var subFormationView: UIView!
    @IBOutlet weak var goDetailFormation: UIButton!
    @IBOutlet weak var subFormationLabel: UILabel!
    static let reuseIdentifier = "SubFormationTableViewCell"
    @available(iOS 13.0, *)
    static let nib = UINib(nibName: SubFormationTableViewCell.reuseIdentifier, bundle: Bundle.local)
    
    @IBAction func subFormationAction(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
