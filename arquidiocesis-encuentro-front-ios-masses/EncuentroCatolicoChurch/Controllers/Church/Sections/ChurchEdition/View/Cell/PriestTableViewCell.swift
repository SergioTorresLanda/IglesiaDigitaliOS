//
//  PriestTableViewCell.swift
//  PriestMyChurches
//
//  Created by Edgar Hernandez Solis on 13/02/21.
//

import UIKit

class PriestTableViewCell: UITableViewCell {
    
    //MARK: - Static values for init
    static let reuseIdentifier = "PriestTableViewCell"
    static let nib = UINib(nibName: PriestTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: PriestTableViewCell.self))
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!

    //MARK: - View controlls
    func fill(with priest: ChurchDetail.Parson?) {
        descriptionLabel.text = priest?.name
    }
    
}
