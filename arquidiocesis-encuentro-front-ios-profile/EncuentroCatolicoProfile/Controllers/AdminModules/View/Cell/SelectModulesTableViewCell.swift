//
//  SelectModulesTableViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 25/06/21.
//

import UIKit
public protocol SellectedModeuleCheckButtonDelegate: AnyObject {
    func didPressCheckButton(sender: UIButton)
}
class SelectModulesTableViewCell: UITableViewCell {
    public weak var delegate: SellectedModeuleCheckButtonDelegate!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chackButton: UIButton!
    var id = Int()
    //MARK: - Static values for init
    static let reuseIdentifier = "SelectModulesTableViewCell"
    static let nib = UINib(nibName: SelectModulesTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: SelectModulesTableViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        delegate?.didPressCheckButton(sender: sender)
    }
}
