//
//  TitleTableViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 15/07/21.
//

import UIKit
protocol TitleCellButtonDelegate: AnyObject {
    func didTapSellectButton(_ sender: UIButton)
}
class TitleTableViewCell: UITableViewCell {
    public weak var delegte: TitleCellButtonDelegate!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sellectButton: UIButton!
    static let reuseIdentifier = "TitleTableViewCell"
    static let nib = UINib(nibName: TitleTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: SelectModulesTableViewCell.self))
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func sellecButtonAction(_ sender: UIButton) {
        delegte?.didTapSellectButton(sender)
    }
}
