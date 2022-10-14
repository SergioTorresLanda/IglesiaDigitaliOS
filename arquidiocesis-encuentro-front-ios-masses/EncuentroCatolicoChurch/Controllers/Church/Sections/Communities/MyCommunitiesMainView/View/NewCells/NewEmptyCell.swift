//
//  NewEmptyCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 10/09/21.
//

import UIKit
public protocol addCommunityNewEmptyButtonDelegate: AnyObject {
    
    func didPressaddCommunityNewEmptyButton(_ sender: UIButton)
}

class NewEmptyCell: UITableViewCell {
    public weak var delegate: addCommunityNewEmptyButtonDelegate?
// MARK: @IBOUTLTES -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var placeHolderImg: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.didPressaddCommunityNewEmptyButton(sender)
    }
}
