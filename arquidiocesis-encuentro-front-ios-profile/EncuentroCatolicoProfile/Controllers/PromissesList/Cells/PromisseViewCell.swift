//
//  PromisseViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

class PromisseViewCell: UITableViewCell {
    static let reuseIdentifier = "PromisseViewCell"
    static let nib = UINib(nibName: PromisseViewCell.reuseIdentifier, bundle: Bundle.local)
    
    @IBOutlet var viewCard: UIView!
    @IBOutlet var descriptionPromisse: UILabel!
    @IBOutlet var timeToOver: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewCard.backgroundColor = .white
        viewCard.layer.cornerRadius = 15
        viewCard.layer.shadowRadius = 7
        viewCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewCard.layer.shadowOpacity = 1
        viewCard.layer.shadowColor = #colorLiteral(red: 0.05098039216, green: 0.2745098039, blue: 0.8392156863, alpha: 0.1483312075)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
